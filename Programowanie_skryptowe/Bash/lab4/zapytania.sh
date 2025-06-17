#!/bin/bash

: '
jq - sluzy do parsowania json
    -r usuwa cudzyslowia z wyniku (raw)
'

#input od uzytkownika
read -p "Podaj nazwe/sciezke do pliku:  " file

#Obliczanie sumy kontrolnej
sum=$(sha256sum $file )
echo "Suma kontrolna(sha256) $sum"


#Wyslanie pliku na serwer do analizy
UPLOAD=$(curl --request POST \
     --url https://www.virustotal.com/api/v3/files \
     --header 'accept: application/json' \
     --header 'content-type: multipart/form-data' \
     --header 'x-apikey: f5269e38dd5a80f21f792c7ff31afd13fcc58aceba453f260abe388bd380850f' \
     --form file="@$file")


#Pobranie id naszego pliku
ID=$(echo "$UPLOAD" | jq -r '.data.id')

#Oczekiwanie az skan sie wykona
echo "Oczekiwanie na wynik analizy..."

#Pobranie informacji o przeprowadzanej analizie
ANALIZA=$(curl --request GET \
     --url https://www.virustotal.com/api/v3/analyses/$ID \
     --header 'accept: application/json' \
     --header 'x-apikey: f5269e38dd5a80f21f792c7ff31afd13fcc58aceba453f260abe388bd380850f')
STATUS=$(echo $ANALIZA | jq -r '.data.attributes.status')

#Oczekiwanie, az analiza dobiegnie konca
while [ "$STATUS" = "queued" ]; do
    ANALIZA=$(curl -s --request GET \
     --url https://www.virustotal.com/api/v3/analyses/$ID \
     --header 'accept: application/json' \
     --header 'x-apikey: f5269e38dd5a80f21f792c7ff31afd13fcc58aceba453f260abe388bd380850f')
     STATUS=$(echo $ANALIZA |jq -r '.data.attributes.status')
     sleep 30
done


#Wydobycie informacji o ilosci wykrytych zagrozen przez rozne AV
WYKRYTE_ZAGROZENIA=$(echo "$ANALIZA" | jq '.data.attributes.stats.malicious')

#Wypisanie czy plik jest zlosliwy|bezpieczny
if [ "$WYKRYTE_ZAGROZENIA" -gt 0 ]; then
    echo "Plik jest zlosliwy! Wykryte zagrozenia: $WYKRYTE_ZAGROZENIA"
else
    echo "Plik jest bezpieczny."
fi