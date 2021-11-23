<#
.SYNOPSIS
	Opens Google Maps
.DESCRIPTION
	This script launches the Web browser with the Google Maps website.
.EXAMPLE
	PS> ./open-google-maps
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/open-default-browser.ps1" "https://www.google.com/maps"
exit 0 # success
