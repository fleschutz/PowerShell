<#
.SYNOPSIS
	Shows Lightnings in OpenStreetMap
.DESCRIPTION
	This script launches the Web browser and shows Lightnings in OpenStreetMap.
.EXAMPLE
	PS> ./show-lightnings
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/open-default-browser.ps1" "https://www.lightningmaps.org"
exit 0 # success
