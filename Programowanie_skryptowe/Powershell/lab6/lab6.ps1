$zawartosc = gc .\input_file.csv
$plik_wyjsciowy = "ComputerReport$(Get-Date -Format yyyyMMdd)-$(Get-Date -Format HHmmss).txt"
for($i = 1;$i -lt $zawartosc.Length; $i++){

    $nazwa, $status = $zawartosc[$i].Split(";")
    $info = ""
    if ($status -eq "True"){

        if ($nazwa -eq "Computername") { $info = "CsName" }
        elseif($nazwa -eq "Manufacturer") { $info = "CsManufacturer" }
        elseif($nazwa -eq "Model") { $info = "CsModel" }
        elseif($nazwa -eq "SerialNumber") {
            Write-Output "SerialNumber: $(Get-WmiObject -Class Win32_BIOS | Select-Object -ExpandProperty SerialNumber)" >> $plik_wyjsciowy
            continue        
        }
        elseif($nazwa -eq "CpuName") {$info = "CsProcessors" }
        elseif($nazwa -eq "RAM") {
            $ram = Get-ComputerInfo | Select-Object -ExpandProperty OsTotalVisibleMemorySize 
            $ram = [math]::Ceiling($ram / 1048576)
            Write-Output "RAM: ${ram}GB" >> $plik_wyjsciowy
            continue           
        }

        Write-Output "${nazwa}: $(Get-ComputerInfo | Select-Object -ExpandProperty $info )" >> $plik_wyjsciowy


        }
}
Write-Host "Raport zosta³ zapisany w pliku: $(Get-Location | Select-Object -ExpandProperty Path)\$plik_wyjsciowy"