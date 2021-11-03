<#
.SYNOPSIS
	Shows Paris in Google Maps 
.DESCRIPTION
	This script launches the Web browser and shows Paris (France) in Google Maps.
.EXAMPLE
	PS> ./show-paris
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/open-browser.ps1" "https://www.google.com/maps/place/Paris"
exit 0 # success
