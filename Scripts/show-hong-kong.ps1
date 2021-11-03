<#
.SYNOPSIS
	Shows Hong Kong in Google Maps 
.DESCRIPTION
	This script launches the Web browser and shows Hong Kong (China) in Google Maps.
.EXAMPLE
	PS> ./show-hong-kong
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/open-browser.ps1" "https://www.google.com/maps/place/Hong+Kong"
exit 0 # success
