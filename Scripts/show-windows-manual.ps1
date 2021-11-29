<#
.SYNOPSIS
	Shows the Microsoft Windows manual
.DESCRIPTION
	This script launches the Web browser with the Microsoft Windows manual.
.EXAMPLE
	PS> ./show-windows-manual
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/open-default-browser.ps1" "https://docs.microsoft.com/en-us/windows/"
exit 0 # success
