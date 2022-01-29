<#
.SYNOPSIS
	Opens the AirBNB website
.DESCRIPTION
	This PowerShell script launches the Web browser with the AirBNB website.
.EXAMPLE
	PS> ./open-air-b-n-b
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz / License: CC0
#>

& "$PSScriptRoot/open-default-browser.ps1" "https://www.airbnb.com"
exit 0 # success
