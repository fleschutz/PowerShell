<#
.SYNOPSIS
	Shows Chicago in Google Maps 
.DESCRIPTION
	This script launches the Web browser and shows Chicago (USA) in Google Maps.
.EXAMPLE
	PS> ./show-chicago-city
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/open-browser.ps1" "https://www.google.com/maps/place/Chicago"
exit 0 # success
