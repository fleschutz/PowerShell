<#
.SYNOPSIS
	Shows planet Earth in Google Maps 
.DESCRIPTION
	This script launches the Web browser and shows planet Earth in Google Maps.
.EXAMPLE
	PS> ./show-planet-earth
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/open-default-browser.ps1" "https://www.google.com/maps/space/earth"
exit 0 # success
