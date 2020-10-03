@echo off
:: redirect stdout to stderr, so the login will be visible in console even if stdout was piped to a file
CALL rcleartool login 1>&2
echo Searching for modified files in %CD%... 1>&2
:: pipe the rcleartool output to the powershell script with the same name as this file
rcleartool lsco -cview -r | Powershell -executionpolicy unrestricted -File "%~dpn0.ps1"