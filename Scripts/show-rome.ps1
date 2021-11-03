<#
.SYNOPSIS
	Shows Rome in Google Maps 
.DESCRIPTION
	This script launches the Web browser and shows Rome (Italy) in Google Maps.
.EXAMPLE
	PS> ./show-rome
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/open-browser.ps1" "https://www.google.com/maps/place/Rome"
exit 0 # success
