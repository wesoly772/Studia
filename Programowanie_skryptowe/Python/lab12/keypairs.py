from Crypto.PublicKey import RSA

def generate_keys(): #Genrujemy klucze asymetryczne
    key = RSA.generate(2048) #Generujemy klucz
    private_key = key.export_key() #Wyodrebniamy prywatny
    public_key = key.public_key().export_key() #Wyodrebniamy publiczny

    #Zapisujemy je do plików
    with open("private.pem",'wb') as f:
        f.write(private_key)
    
    with open("public.pem","wb") as f:
        f.write(public_key)

generate_keys()
print("Wygenerowano klucze!")