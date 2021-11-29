<#
.SYNOPSIS
	Shows Munich city in Google Maps 
.DESCRIPTION
	This script launches the Web browser with Google Maps at Munich city (Germany).
.EXAMPLE
	PS> ./show-munich-city
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/open-default-browser.ps1" "https://www.google.com/maps/place/Munich"
exit 0 # success
