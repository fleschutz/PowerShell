<#
.SYNOPSIS
	Shows Cape Town in Google Maps 
.DESCRIPTION
	This script launches the Web browser and shows Cape Town (South Africa) in Google Maps.
.EXAMPLE
	PS> ./show-cape-town
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/open-browser.ps1" "https://www.google.com/maps/place/Cape+Town"
exit 0 # success
