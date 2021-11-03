<#
.SYNOPSIS
	Shows London in Google Maps 
.DESCRIPTION
	This script launches the Web browser and shows London (UK) in Google Maps.
.EXAMPLE
	PS> ./show-london
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/open-browser.ps1" "https://www.google.com/maps/place/London"
exit 0 # success
