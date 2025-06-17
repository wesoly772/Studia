$sciezka = Read-Host -Prompt "Podaj sciezke do folderu: "

if  ( -not (Test-Path -Path $sciezka) ){
    mkdir $sciezka
}
while (1){
    if (Test-Path -Path "$sciezka\*.txt"){
        Move-Item "$sciezka\*.txt" "C:\Users\Patryk\Desktop\w" -Force
    }else{
        continue
    }
}