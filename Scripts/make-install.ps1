#!/bin/powershell
<#
.SYNTAX         make-install.ps1 <build-dir>
.DESCRIPTION	Copies newer EXE's + DLL's from the build directory to the installation directory.
.LINK		https://github.com/fleschutz/PowerShell
.NOTES		Author:	Markus Fleschutz / License: CC0
#>

set SRC_DIR=%1
set "DST_DIR=C:\Program Files\MyApp\bin"
set FILTER=*.exe *.dll
set OPTIONS=/E /njh /np

try {
	title Syncing to %DST_DIR% ...
	robocopy %SRC_DIR% %DST_DIR% %FILTER% %OPTIONS%

	echo ------------------------------------------------------------------------------
	echo.
	echo DONE - synced to %DST_DIR%
	echo.
	pause
	exit 0
} catch {
	write-error "ERROR in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
