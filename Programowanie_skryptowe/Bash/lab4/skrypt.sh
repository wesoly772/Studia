#!/bin/bash

#Pytanie o nazwe uzytkownika
#read -p "Podaj nazwe uzytkownika: " username

#Tworzenie uzytkownika wraz z katalogiem domowym i podkatalogami
function add_user(){
    useradd -m $1 -g kali -s /bin/bash
    passwd -d $1
}
function create_dirs(){
    cd /home/$1
    mkdir Documents Pictures Videos
    cd -
}

#Aktualizacja repozytorium i instalacja aktualizacji
function updates(){
    apt -y update
    apt -y upgrade
}

#Instalacja programu thunderbird
function thunderbird_install(){
    apt -y install thunderbird
}


#Wypisywanie informacji o systemie
function info(){
    #Pobranie informacji o uzywanym interfejsie i ip
    ipmac=($( ip route get 1.1.1.1 | awk '{print $(NF-2),$(NF-4)}' 2>/dev/null))
    echo "Wersja: $( uname -r )"  
    echo "IP: " "${ipmac[0]}"
    echo "MAC: " $(ifconfig "${ipmac[1]}" | awk '/ether/ {print $2}')

}

info
