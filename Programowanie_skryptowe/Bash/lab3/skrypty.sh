#!/bin/bash

#Z1a
# if [ $# != 2 ]; then
#     echo "Podaj argumenty!"
# fi
# imie=$1
# wiek=$2
# echo "Imie: $imie, Wiek: $wiek"

#Z1b
# read -p "Podaj dlugosc boku prostokata: " dlugosc
# read -p "Podaj szerokosc prostokata: " szerokosc
# echo "Pole powierzchni wynosi: $(($dlugosc * $szerokosc))"

# Z2a
# read -p "Podaj nazwe uzytkownika: " usern
# if [ -z $usern ]; then
#     echo "Nie podano nazwy!"
#     exit
# fi
# if [[ -n $(groups $usern | grep sudo) || "$usern" == "root" ]]; then
#     echo "Konto admina"
# else
#     echo "To nie jest konto admina"
# fi

#Z2b
# read -p "Podaj sciezke do pliku: " sciezka

# if [ -e $sciezka ]; then
#     echo "Plik istnieje"
#     #
#     if [ -s $sciezka ]; then
#         echo "Plik nie jest pusty"
#     else
#         echo "Plik jest pusty"
#     fi
#     #
#     if [ -d $sciezka ]; then
#         echo "Plik jest katalogiem!"
#     else
#         echo "Plik nie jest katalogiem!"
#     fi
#     #
# else
#     echo "Plik nie istnieje"
# fi

#Z3a
# read -p "Podaj liczbe: " liczba

# if [[ $liczba -gt 0 && $((liczba % 2)) != 0 ]]; then
#     echo "Liczba jest dodatnia i nieparzysta"
# else
#     echo "Liczba nie jest dodatnia lub nieparzysta"
# fi

# #Z3b

# read -p "Podaj nazwe uzytkownika: " username
# read -p "Podaj haslo: " pass

# if [[ "$username" == "admin" && "$pass" == "password" ]]; then
#     echo "Podano prawidlowe dane!"
# else
#     echo "Podano nieprawidlowe dane!"
# fi

# #Z4a

# tablica=()

# for ((i=1; i<11; i++)); do
#     tablica[$i-1]="192.168.1.$i"
# done
# echo "${tablica[@]}"

#Z4b
# tablica=()
# counter=1
# while [ $counter -lt 11 ]; do
#     tablica[$counter-1]="192.168.1.$counter"
#     ((counter++))
# done
# echo "${tablica[@]}"

# #Z5

NAME=$(hostname)

function data() {
    echo "Aktualna data na $NAME to: $(date)"
}
function wersja() {
    echo "Aktualna wersja na $NAME to: $(uname -r)"
}
function uzytkownik() {
    echo "Aktualny uzytkownik na $NAME to: $(whoami)"
}
function adresIP() {
    echo "Aktualny adres IP na $NAME to: $(ip route get 1.1.1.1 | awk '{print $(NF-2);exit}' )"
}
data
wersja
uzytkownik
adresIP