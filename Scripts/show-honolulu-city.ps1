<#
.SYNOPSIS
	Shows Honolulu city in Google Maps 
.DESCRIPTION
	This script launches the Web browser with Google Maps at Honolulu city (USA).
.EXAMPLE
	PS> ./show-honolulu-city
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/open-default-browser.ps1" "https://www.google.com/maps/place/Honolulu"
exit 0 # success
