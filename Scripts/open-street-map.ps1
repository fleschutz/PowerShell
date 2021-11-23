<#
.SYNOPSIS
	Opens the OpenStreetMap website
.DESCRIPTION
	This script launches the Web browser with the OpenStreetMap website.
.EXAMPLE
	PS> ./open-street-map
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/open-default-browser.ps1" "https://www.openstreetmap.org"
exit 0 # success
