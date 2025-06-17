#Skrypt przyjmuje argument ze sciezka do pliku
param(
    $plik
)

#Obliczamy hash pliku
$hash = Get-FileHash -Algorithm SHA256 -Path $plik | Select-Object -ExpandProperty Hash

#Przypisujemy odpowiednie naglówki
$headers=@{}
$headers.Add("accept", "application/json")
$headers.Add("x-apikey", "f5269e38dd5a80f21f792c7ff31afd13fcc58aceba453f260abe388bd380850f")

#Wysy³amy zapytanie do VirusTotala
$response = Invoke-WebRequest -Uri "https://www.virustotal.com/api/v3/files/$hash"  -Method GET -Headers $headers | ConvertFrom-Json

#Po pomyœlnym uzyskaniu odpowiedzi sprawdzamy czy aplikacja wykry³a jakieœ zgro¿enia
$stat = $response.data.attributes.last_analysis_stats.malicious
if ($stat -gt 0){
    Write-Host "Plik jest szkodliwy!"
}else{
    Write-Host "Plik jest nieszkodliwy!"
}



