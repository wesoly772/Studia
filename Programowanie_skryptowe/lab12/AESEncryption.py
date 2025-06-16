from os import urandom #bibloteka do tworzenia kluczy
from Crypto.Cipher import AES #biblioteka do szyfru AES

def encrypt(key,message): #Szyfracja

    cipher = AES.new(key,AES.MODE_EAX) #Tworzymy szyfr
    nonce = cipher.nonce #Liczba losowa, jednorazowa - powoduje, że szyfr za każdym razem jest inny
    ciphertext, tag = cipher.encrypt_and_digest(message) # Szyfrujemy wiadomosc
    return ciphertext, tag, nonce #Zwracamy szyfrogram, tag - sluzy do sprawdzenia spojności szyfru

def decrypt(key,ciphertext,tag,nonce): #Deszyfracja
    cipher = AES.new(key,AES.MODE_EAX, nonce=nonce) 
    plaintext=cipher.decrypt_and_verify(ciphertext,tag)
    return plaintext

#Szyfrowanie
message="Wiadomość12345".encode("utf-8") #Kodujemy wiadomość do postaci bitow
key=urandom(32) #Tworzymy losowy 256 bitowy klucz
ciphertext,tag,nonce=encrypt(key,message)
print(f"Zaszyfrowana wiadomość: {ciphertext}")

#Deszyfrowanie
message_decrypted=decrypt(key,ciphertext,tag,nonce).decode("utf-8") #Dekodujemy wiadomosc
print(f"Odszyfrowana wiadomość: {message_decrypted}")


