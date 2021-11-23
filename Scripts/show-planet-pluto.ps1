<#
.SYNOPSIS
	Shows planet Pluto in Google Maps 
.DESCRIPTION
	This script launches the Web browser and shows planet Pluto in Google Maps.
.EXAMPLE
	PS> ./show-planet-pluto
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/open-default-browser.ps1" "https://www.google.com/maps/space/pluto"
exit 0 # success
