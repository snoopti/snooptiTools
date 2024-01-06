@echo off
set "version=v1.0.8"
set "author=snoopti"
set "updateURL=https://raw.githubusercontent.com/snoopti/snooTools/main/snooTools.bat"
set "sourceCode=https://github.com/snoopti/snooTools"
set "name=snooTools"

title %name% - %version% - by %author%

:checkAdmin
::----------------- Admin-Check
net session >nul 2>&1
if %errorLevel% NEQ 0 (
    echo Running in Administrator mode...
    powershell -command "Start-Process '%~0' -Verb RunAs"
    exit /b
)

::----------------- Menu
:menu
cls
echo.
echo ---------- %name% %version% ----------
echo.
echo [1] Winget Updater
echo [2] Cleaner
echo.
echo [#] Update Version
echo [?] Sourcecode
echo [!] Exit
echo.
set /p choice=Insert option: 

if "%choice%"=="1" goto tool-updater
if "%choice%"=="2" goto tool-cleaner

if "%choice%"=="#" goto updateversion
if "%choice%"=="?" goto sourcecode
if "%choice%"=="-" goto changelog
if "%choice%"=="!" exit /b

cls
echo Invalid choice. Please select a valid option.
timeout /t 2 >nul
goto menu

::---------------------------------- GENERAL ----------------------------------
::----------------- VersionUpdate
:updateversion
cls
echo.
echo Downloading newest Version
echo.
timeout /t 2 >nul
curl -o temp.bat %updateURL%
timeout /t 1 >nul
move /y temp.bat "%~0"
timeout /t 3 >nul
exit /b

::----------------- Sourcecode
:sourcecode
cls
start %sourceCode%
goto menu

::---------------------------------- TOOLS ----------------------------------
::----------------- WingetUpdater
:tool-updater
cls
echo.
echo ---------- UPDATER ----------
echo.
echo Update process starting...
echo.
timeout /t 5 >nul
cls

winget list
winget upgrade --all
winget upgrade --all --include-unknown

echo Update process complete.
timeout /t 10 >nul
goto menu

::----------------- Cleaner
setlocal enabledelayedexpansion

:cleanFolder
if exist "%~1" (
    rmdir /s /q "%~1" 2>nul
    if errorlevel 1 (
        echo Failed to clean %~1. Possibly in use.
    ) else (
        echo Successfully cleaned %~1
    )
) else (
    echo Folder not found, skipping cleanup
)
timeout /t 3 >nul
exit /b

:tool-cleaner
cls
echo.
echo ---------- CLEANER ----------
echo.
echo You can ignore any errors like access denied or something; it's normal when some files are currently used by some programs.
echo.
echo Sit back and wait for it to finish.
timeout /t 5 >nul
cls

echo [1] Cleaning Temporary Files
call :cleanFolder "C:\Users\%USERNAME%\AppData\Local\Temp"

echo [2] Cleaning Windows Temporary Files
call :cleanFolder "C:\Windows\Temp"

echo [3] Cleaning Chrome Service Worker Cache
call :cleanFolder "C:\Users\%USERNAME%\AppData\Local\Google\Chrome\User Data\Default\Service Worker\CacheStorage"

echo [4] Cleaning Nvidia DXCache
call :cleanFolder "C:\Users\%USERNAME%\AppData\Local\NVIDIA\DXCache"

echo [5] Cleaning Old Windows Files
call :cleanFolder "C:\windows.old"

cls
echo Cleaner finished.
pause
goto menu