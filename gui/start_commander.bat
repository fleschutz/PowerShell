@echo off
REM PowerShell Commander - Windows Startup Script
REM This script launches the PowerShell Commander GUI application

REM Get the directory where this script is located
set SCRIPT_DIR=%~dp0

REM Check if Python is available
where python >nul 2>nul
if %ERRORLEVEL% NEQ 0 (
    echo Python not found. Please install Python 3.8 or higher.
    echo Download from: https://www.python.org/downloads/
    pause
    exit /b 1
)

REM Check if customtkinter is installed
python -c "import customtkinter" >nul 2>nul
if %ERRORLEVEL% NEQ 0 (
    echo Installing required dependencies...
    pip install -r "%SCRIPT_DIR%requirements.txt"
)

REM Launch the application
echo Starting PowerShell Commander...
cd /d "%SCRIPT_DIR%"
start "" pythonw powershell_commander.py

REM If pythonw fails (not available), try python
if %ERRORLEVEL% NEQ 0 (
    python powershell_commander.py
)
