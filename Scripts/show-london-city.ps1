<#
.SYNOPSIS
	Shows London in Google Maps 
.DESCRIPTION
	This script launches the Web browser and shows London city (UK) in Google Maps.
.EXAMPLE
	PS> ./show-london-city
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/open-default-browser.ps1" "https://www.google.com/maps/place/London"
exit 0 # success
