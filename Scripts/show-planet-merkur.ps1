<#
.SYNOPSIS
	Shows planet Merkur in Google Maps 
.DESCRIPTION
	This script launches the Web browser and shows planet Merkur in Google Maps.
.EXAMPLE
	PS> ./show-planet-merkur
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/open-default-browser.ps1" "https://www.google.com/maps/space/mercury"
exit 0 # success
