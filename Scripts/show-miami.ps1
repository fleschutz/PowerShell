<#
.SYNOPSIS
	Shows Miami in Google Maps 
.DESCRIPTION
	This script launches the Web browser and shows Miami (US) in Google Maps.
.EXAMPLE
	PS> ./show-miami
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/open-browser.ps1" "https://www.google.com/maps/place/Miami"
exit 0 # success
