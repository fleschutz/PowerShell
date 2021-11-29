<#
.SYNOPSIS
	Shows Madrid city in Google Maps 
.DESCRIPTION
	This script launches the Web browser with Google Maps at Madrid city (Spain).
.EXAMPLE
	PS> ./show-madrid-city
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/open-default-browser.ps1" "https://www.google.com/maps/place/Madrid"
exit 0 # success
