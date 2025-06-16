from Crypto.Hash import SHA256
from Crypto.PublicKey import RSA
from Crypto.Signature import PKCS1_v1_5
from sys import argv, exit
import os


def usage(): #Informuje jak uzyć skryptu
    print("Użycie: \n"
          "digitalsignature.py\n-s <file_name> <private_key>  <---- sign a file\n"
          "-v <file_name> <public_key> <signature>  <---- verify a signature\n")



def sign_file(file,private_key_path): #Podpisanie pliku

    try:
        with open(private_key_path,"rb") as f:  #Odczytujemy binarnie klucz prywatny
            private_key = RSA.import_key(f.read())
        with open(file,"rb") as f: #Odczytujemy biarnie plik
            data = f.read()

    except FileNotFoundError as e:
        print(f"Nie znaleziono pliku: {e.filename}")
        exit(1)
    

    hash256 = SHA256.new(data) #Tworzmy hash pliku
    signature = PKCS1_v1_5.new(private_key).sign(hash256) #Podpisujemy kluczem prywatnym hash i tworzymy sygnature

    with open(f"{file}.sig", "wb") as f: #Zapisujemy sygnature do pliku
        f.write(signature)

    print(f"Podpisano plik!")

def verify_file(file,signature_path,public_key_path): #Weryfikacja sygnatury

    try:
        with open(public_key_path,"rb") as f: #Odczytujemy biarnie klucz publiczny
            public_key = RSA.import_key(f.read())

        with open(file,"rb") as f: #Odczytujemy biarnie plik
            data = f.read()
    
        with open(signature_path,"rb") as f: #Odczytujemy biarnie sygnature
            signature=f.read()

    except FileNotFoundError as e:
        print(f"Nie znaleziono pliku: {e.filename}")
        exit(1)


    hash256 = SHA256.new(data)  #Tworzymy hash pliku
    if PKCS1_v1_5.new(public_key).verify(hash256,signature): #Deszyfrujemy sygnature kluczem publicznym i porównujemy z obliczonym hashem
        print("Plik jest zgodny!")
    else:
        print("Plik nie jest zgodny!")
    exit(-1)
        



def main():
    if len(argv) < 2 or argv[1] not in ("-s","-v"):  #Sprawdzamy czy uzykownik podaje odpowiednia ilosc argumentow
        usage()
        exit()

    elif argv[1] == "-s":
        if len(argv) != 4:
            usage()
            exit(1)
        sign_file(argv[2],argv[3])
    
    elif argv[1] == "-v":
        if len(argv) != 5:
            usage()
            exit(1)
        verify_file(argv[2],argv[4],argv[3])
        
        
        

if __name__ == "__main__":
    main()

