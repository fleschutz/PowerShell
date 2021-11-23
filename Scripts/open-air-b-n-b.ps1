<#
.SYNOPSIS
	Opens the AirBNB website
.DESCRIPTION
	This script launches the Web browser with the AirBNB website.
.EXAMPLE
	PS> ./open-air-b-n-b
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/open-default-browser.ps1" "https://www.airbnb.com"
exit 0 # success
