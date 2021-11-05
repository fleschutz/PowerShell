<#
.SYNOPSIS
	Shows Cairo in Google Maps 
.DESCRIPTION
	This script launches the Web browser and shows Cairo (Egypt) in Google Maps.
.EXAMPLE
	PS> ./show-cairo
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/open-browser.ps1" "https://www.google.com/maps/place/Cairo"
exit 0 # success
