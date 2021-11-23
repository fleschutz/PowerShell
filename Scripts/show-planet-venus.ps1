<#
.SYNOPSIS
	Shows planet Venus in Google Maps 
.DESCRIPTION
	This script launches the Web browser and shows planet Venus in Google Maps.
.EXAMPLE
	PS> ./show-planet-venus
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/open-default-browser.ps1" "https://www.google.com/maps/space/venus"
exit 0 # success
