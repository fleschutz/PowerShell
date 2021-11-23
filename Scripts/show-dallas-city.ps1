<#
.SYNOPSIS
	Shows Dallas in Google Maps 
.DESCRIPTION
	This script launches the Web browser and shows the city of Dallas (USA) in Google Maps.
.EXAMPLE
	PS> ./show-dallas-city
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/open-default-browser.ps1" "https://www.google.com/maps/place/Dallas"
exit 0 # success
