<#
.SYNOPSIS
	Shows Cape Town city in Google Maps 
.DESCRIPTION
	This script launches the Web browser with Google Maps at Cape Town city (South Africa).
.EXAMPLE
	PS> ./show-cape-town-city
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/open-default-browser.ps1" "https://www.google.com/maps/place/Cape+Town"
exit 0 # success
