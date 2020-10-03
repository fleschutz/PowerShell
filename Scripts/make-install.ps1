@echo off
::
:: Syntax:	make-install.ps1 <build-dir>
:: Description:	Copies newer EXE's + DLL's from the build directory to the installation directory.
:: Author:	Markus Fleschutz
::

set SRC_DIR=%1
set "DST_DIR=C:\Program Files\MyApp\bin"
set FILTER=*.exe *.dll
set OPTIONS=/E /njh /np

title Syncing to %DST_DIR% ...
robocopy %SRC_DIR% %DST_DIR% %FILTER% %OPTIONS%

echo ------------------------------------------------------------------------------
echo.
echo DONE - synced to %DST_DIR%
echo.
pause
exit /b 0
