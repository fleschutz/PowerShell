@echo off
REM PowerShell Commander - Add to Windows Startup
REM Run this script once to make PowerShell Commander start with Windows

echo ==============================================
echo PowerShell Commander - Startup Installation
echo ==============================================
echo.

REM Get the directory where this script is located
set SCRIPT_DIR=%~dp0

REM Create startup shortcut
set STARTUP_FOLDER=%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup
set SHORTCUT_PATH=%STARTUP_FOLDER%\PowerShell Commander.lnk

REM Use PowerShell to create the shortcut
powershell -Command "$WshShell = New-Object -ComObject WScript.Shell; $Shortcut = $WshShell.CreateShortcut('%SHORTCUT_PATH%'); $Shortcut.TargetPath = '%SCRIPT_DIR%start_commander.bat'; $Shortcut.WorkingDirectory = '%SCRIPT_DIR%'; $Shortcut.WindowStyle = 7; $Shortcut.Description = 'PowerShell Commander GUI'; $Shortcut.Save()"

if %ERRORLEVEL% EQU 0 (
    echo.
    echo SUCCESS! PowerShell Commander will now start with Windows.
    echo.
    echo Shortcut created at:
    echo %SHORTCUT_PATH%
    echo.
    echo To remove from startup, delete the shortcut from:
    echo %STARTUP_FOLDER%
) else (
    echo.
    echo ERROR: Failed to create startup shortcut.
    echo Please try running this script as Administrator.
)

echo.
pause
