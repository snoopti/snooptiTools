@echo off
set "version=v1.0.7"
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
echo [2] Calculator
echo.
echo [#] Download latest version
echo [?] Sourcecode (github)
echo [-] Changelog
echo [!] Exit
echo.
set /p choice=Insert option: 

if "%choice%"=="1" goto tool-updater
if "%choice%"=="2" goto tool-calculator
if "%choice%"=="#" goto updateversion
if "%choice%"=="?" goto sourcecode
if "%choice%"=="-" goto changelog
if "%choice%"=="!" exit /b

cls
echo Invalid choice. Please select a valid option.
timeout /t 2 >nul
goto menu

::----------------- WingetUpdater
:tool-updater
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
goto menu

::----------------- Calculator
:tool-calculator
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
goto op-calculator

::----------------- VersionUpdate
:updateversion
cls
echo.
echo Downloading from %updateURL%
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

::----------------- Changelog
:changelog 
cls
echo.
echo ---------- CHANGELOG ----------
echo.
echo ----- v1.0.7
echo + optimization
echo + name changed
echo + changed updatelink
echo.
echo ----- v1.0.6
echo + sourcecode link added
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
goto menu