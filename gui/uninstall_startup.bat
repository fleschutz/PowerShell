@echo off
REM PowerShell Commander - Remove from Windows Startup

echo ==============================================
echo PowerShell Commander - Remove from Startup
echo ==============================================
echo.

set STARTUP_FOLDER=%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup
set SHORTCUT_PATH=%STARTUP_FOLDER%\PowerShell Commander.lnk

if exist "%SHORTCUT_PATH%" (
    del "%SHORTCUT_PATH%"
    echo SUCCESS! PowerShell Commander removed from startup.
) else (
    echo PowerShell Commander was not in startup.
)

echo.
pause
