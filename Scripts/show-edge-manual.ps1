<#
.SYNOPSIS
	Shows the Microsoft Edge manual
.DESCRIPTION
	This script launches the Web browser with the Microsoft Edge manual.
.EXAMPLE
	PS> ./show-edge-manual
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/open-default-browser.ps1" "https://docs.microsoft.com/en-us/microsoft-edge/"
exit 0 # success
