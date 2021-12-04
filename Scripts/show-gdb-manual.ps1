<#
.SYNOPSIS
	Shows the GDB manual
.DESCRIPTION
	This script launches the Web browser with the GDB manual.
.EXAMPLE
	PS> ./show-gdb-manual
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/open-default-browser.ps1" "https://www.gnu.org/software/gdb/documentation/"
exit 0 # success
