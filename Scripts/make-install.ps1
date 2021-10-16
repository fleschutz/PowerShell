<#
.SYNOPSIS
	Copies newer EXE's + DLL's from the build directory to the installation directory
.DESCRIPTION
	This script copies newer EXE's + DLL's from the build directory to the installation directory.
.EXAMPLE
	PS> ./make-install
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
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

	"✔️ synced to %DST_DIR%"
	exit 0 # success
} catch {
	"⚠️ Error: $($Error[0]) ($($MyInvocation.MyCommand.Name):$($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
