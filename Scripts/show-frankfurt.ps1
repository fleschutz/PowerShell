<#
.SYNOPSIS
	Shows Frankfurt in Google Maps 
.DESCRIPTION
	This script launches the Web browser and shows Frankfurt (Germany) in Google Maps.
.EXAMPLE
	PS> ./show-frankfurt
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/open-browser.ps1" "https://www.google.com/maps/place/Frankfurt"
exit 0 # success
