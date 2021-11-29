<#
.SYNOPSIS
	Shows Dubai city in Google Maps 
.DESCRIPTION
	This script launches the Web browser with Google Maps at Dubai city (VUE).
.EXAMPLE
	PS> ./show-dubai-city
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/open-default-browser.ps1" "https://www.google.com/maps/place/Dubai"
exit 0 # success
