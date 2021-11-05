<#
.SYNOPSIS
	Shows Sydney in Google Maps 
.DESCRIPTION
	This script launches the Web browser and shows Sydney (Australia) in Google Maps.
.EXAMPLE
	PS> ./show-sydney
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/open-browser.ps1" "https://www.google.com/maps/place/Sydney"
exit 0 # success
