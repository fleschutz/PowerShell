<#
.SYNOPSIS
	Shows Hong Kong city in Google Maps 
.DESCRIPTION
	This script launches the Web browser with Google Maps at Hong Kong city (China).
.EXAMPLE
	PS> ./show-hong-kong-city
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/open-default-browser.ps1" "https://www.google.com/maps/place/Hong+Kong"
exit 0 # success
