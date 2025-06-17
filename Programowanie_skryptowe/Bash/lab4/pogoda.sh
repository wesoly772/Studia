#!/bin/bash

#Pobieramy dane za pomoca api o pogodzie w danym miescie
DANE=$(curl -s -X GET "http://api.weatherapi.com/v1/forecast.json?key=79e2781f1c6848d0919154502252703&q=$1&days=5&aqi=no&alerts=no")

#za pomoca narzedzia jq pobieramy wartosci pliku json:

#Pobieramy dzisiejsza date
DATA=$(echo $DANE | jq -r '.location.localtime')
#Pobieramy Aktualna temperature
TEMP=$(echo $DANE | jq '.current.temp_c')
#Pobieramy Aktualna wilgotnosc
HUMIDITY=$(echo $DANE | jq '.current.humidity')
#Przekierowujemy dane do pliku raport.txt | -e umozliwia uzycie znakow specjalnych
echo -e "Miasto: $1 \n\n  Data: $DATA \n\t Aktualna temperatura: ${TEMP}C \n\t Aktualna wilgotnosc: ${HUMIDITY}% \n" > raport.txt

#Za pomoca petli przechodzimy przez kolejne dni i pobieramy informacje
for i in {0..4}; do
    #Data
    DATA=$(echo "$DANE" | jq -r ".forecast.forecastday[$i].date")
    #Srednia temperatura w ciagu dnia
    TEMP=$(echo "$DANE" | jq -r ".forecast.forecastday[$i].day.avgtemp_c")
    #Srednia wilgotnosc w ciagu dnia
    HUMIDITY=$(echo "$DANE" | jq -r ".forecast.forecastday[$i].day.avghumidity")
    #Przekierowujemy dane do pliku 
    echo -e "Data: $DATA \n\t Temperatura: ${TEMP}C \n\t Wilgotnosc: ${HUMIDITY}% \n" >> raport.txt
done

#Za pomoca narzedzia pandoc tworzymy raport
pandoc raport.txt -o raport.pdf
rm raport.txt

