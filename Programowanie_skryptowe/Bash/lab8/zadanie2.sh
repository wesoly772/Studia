#!/bin/bash

#Zamieniamy spacje na %20(dla URL to spacja)
arg=$(echo "$*" | sed 's/ /%20/g')
ZAPYTANIE=$(curl -s "https://newsdata.io/api/1/news?apikey=pub_856231e167876ad11b0dc30e276737d36b640&q=$arg&country=pl" )
ilosc_wynikow=$(echo "$ZAPYTANIE" | jq -r .totalResults)


#API pozwala tylko na wyniki sprzed 2 dni :(
echo "Znalezione linki: "
for((i=0;i<ilosc_wynikow;i++)); do
    wynik=$(echo "$ZAPYTANIE" | jq -r .results[$i].link)
    if [ $wynik = "null" ]; then
        continue
    fi
    echo $wynik
done

