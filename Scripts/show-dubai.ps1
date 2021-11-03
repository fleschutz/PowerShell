<#
.SYNOPSIS
	Shows Dubai in Google Maps 
.DESCRIPTION
	This script launches the Web browser and shows New York City (US) in Google Maps.
.EXAMPLE
	PS> ./show-dubai
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/open-browser.ps1" "https://www.google.com/maps/place/Dubai"
exit 0 # success
