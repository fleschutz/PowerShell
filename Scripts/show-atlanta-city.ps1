<#
.SYNOPSIS
	Shows Atlanta city in Google Maps 
.DESCRIPTION
	This script launches the Web browser with Google Maps at Atlanta city (USA).
.EXAMPLE
	PS> ./show-atlanta-city
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/open-default-browser.ps1" "https://www.google.com/maps/place/Atlanta"
exit 0 # success
