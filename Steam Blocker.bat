@ECHO OFF
title Steam Blocker 1.0

:: BatchGotAdmin (Run as Admin code starts)

REM --> Check for permissions
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"

REM --> If error flag set, we do not have admin.
if '%errorlevel%' NEQ '0' (
echo Requesting administrative privileges...
goto UACPrompt
) else ( goto gotAdmin )

:UACPrompt
echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
echo UAC.ShellExecute "%~s0", "", "", "runas", 1 >> "%temp%\getadmin.vbs"

"%temp%\getadmin.vbs"
exit /B

:gotAdmin
if exist "%temp%\getadmin.vbs" ( del "%temp%\getadmin.vbs" )
pushd "%CD%"
CD /D "%~dp0"

:MAIN
cls
echo Select an option
echo.
echo 1 - Block Steam
echo 2 - Un-Block Steam
set /p menu=Select a number: 
if "%menu%"=="1" goto BLOCK
if "%menu%"=="2" goto UNBLOCK
echo Invalid choice
pause
goto MAIN
:BLOCK
cls
netsh advfirewall firewall add rule name="BlockSteam" protocol=any dir=out program="F:\Steam\Steam.exe" action=block
netsh advfirewall firewall add rule name="BlockSteam" protocol=any dir=in program="F:\Steam\Steam.exe" action=block
echo Your steam is now blocked enjoy the anonymity...
pause
goto MAIN
:UNBLOCK
cls
netsh advfirewall firewall delete rule name="BlockSteam"
echo Your steam is now Un-Blocked...
pause
goto MAIN