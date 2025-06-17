#!/bin/bash

ZAPYTANIE=$( curl -s -X GET "https://api.nbp.pl/api/exchangerates/rates/a/$1/last/6/?format=json" )

kurs_wczesniej=$(echo "$ZAPYTANIE" | jq -r .rates[0].mid )
for((i=1;i<6;i++)); do
    data=$(echo "$ZAPYTANIE" | jq -r .rates[$i].effectiveDate )
    kurs=$(echo "$ZAPYTANIE" | jq  .rates[$i].mid )
    echo "Data: $data"
    echo "Kurs sredni: $kurs"
    echo "Roznica do dnia wczesniejszego: " $(echo "$kurs-$kurs_wczesniej" | bc)
    echo ""
    kurs_wczesniej=$kurs
done

