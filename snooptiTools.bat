@echo off
set "version=v1.1.5 (beta)"
set "author=snoopti"
set "updateURL=https://snoopti.de/download/snooptiTools.bat"

title snooptiTools - %version% - by %author%

:: Admin-Check
net session >nul 2>&1
if %errorLevel% == 0 (
    goto :menu
) else (
    goto :runAsAdmin
)
:: ----------

:: Menu
:menu
cls
echo.
echo ---------- SNOOPTI-TOOLS %version% ----------
echo.
echo [1] Winget Updater
echo [2] Calculator
echo.
echo [#] Download latest version
echo [?] Sourcecode (github)
echo [-] Changelog
echo [!] Exit
echo.
set /p choice=Insert option: 

if "%choice%"=="1" (
    goto :op-updater
) else if "%choice%"=="2" (
    goto :op-calculator
) else if "%choice%"=="#" (
    goto :updateversion
) else if "%choice%"=="?" (
    goto :sourcecode
) else if "%choice%"=="-" ( 
    goto :changelog
) else if "%choice%"=="!" (
    exit
) else (
    cls
    echo Invalid choice. Please select a valid option.
    timeout /t 2 >nul
    goto :menu
)
:: ----------

:: ------------------------------------ OPTIONS

:: option1 - WingetUpdater
:op-updater
cls
echo.
echo ---------- UPDATER ----------
echo.
echo Update process starting...
echo ! please refrain from any actions during the process
timeout /t 5 >nul
cls

winget list
winget upgrade --all
winget upgrade --all --include-unknown

echo Update process complete.
timeout /t 10 >nul
goto :menu
:: ----------

:: Option2 - Calculator
:op-calculator
cls
echo.
echo ---------- CALCULATOR ----------
echo.
echo Insert calculation:
set /p "expression="
echo.
for /f "delims=" %%a in ('powershell -command "write-host (%expression%)"') do set "result=%%a"
echo Result: %result%
pause >nul
goto :op-calculator
:: ----------

:: ------------------------------------
:: ------------------------------------ SYSTEM

:: UPDATE LATEST VERSION
:updateversion
cls
echo.
echo Downloading from %updateURL%
echo.
timeout /t 2 >nul
curl -o temp.bat %updateURL%
timeout /t 1 >nul
move /y temp.bat "%~0"
cls
echo.
echo Latest version of snooptiTools.bat successfully downloaded.
echo please wait..
echo.
timeout /t 3 >nul
exit
:: ----------

:: RunAsAdmin
:runAsAdmin
cls
echo Running in Administrator mode...
powershell -command "Start-Process '%~0' -Verb RunAs"
exit
:: ----------

:sourcecode
cls
echo.
echo github.com/snoopti/snooptiTools will be open in 3 seconds
timeout /t 3 >nul
start https://github.com/snoopti/snooptiTools
goto :menu

:: Changelog
:changelog 
cls
echo.
echo ---------- CHANGELOG ----------
echo.
echo ----- v1.0.5
echo changed version updater method
echo.
echo ----- v1.0.4
echo + changelog
echo.
echo ----- v1.0.3
echo bug fixes
echo.
echo ----- v1.0.2
echo design update
echo.
echo ----- v1.0.1
echo + Winget updater
echo + Calculator
echo + Download latest version
echo.
echo ----- v1.0.0
echo Beta Release
echo.
pause
goto :menu
:: ----------

:: ------------------------------------