<#
.SYNOPSIS
	Shows Singapore in Google Maps 
.DESCRIPTION
	This script launches the Web browser and shows Singapore in Google Maps.
.EXAMPLE
	PS> ./show-singapore
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/open-browser.ps1" "https://www.google.com/maps/place/Singapore"
exit 0 # success
