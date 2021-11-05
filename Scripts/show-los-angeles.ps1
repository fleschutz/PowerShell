<#
.SYNOPSIS
	Shows Los Angeles in Google Maps 
.DESCRIPTION
	This script launches the Web browser and shows Los Angeles (USA) in Google Maps.
.EXAMPLE
	PS> ./show-los-angeles
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/open-browser.ps1" "https://www.google.com/maps/place/Los+Angeles"
exit 0 # success
