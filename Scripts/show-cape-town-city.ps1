<#
.SYNOPSIS
	Shows Cape Town in Google Maps 
.DESCRIPTION
	This script launches the Web browser and shows Cape Town city (South Africa) in Google Maps.
.EXAMPLE
	PS> ./show-cape-town-city
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/open-default-browser.ps1" "https://www.google.com/maps/place/Cape+Town"
exit 0 # success
