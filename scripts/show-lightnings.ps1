<#
.SYNOPSIS
	Shows Lightnings in OpenStreetMap
.DESCRIPTION
	This PowerShell script launches the Web browser and shows lightnings in OpenStreetMap.
.EXAMPLE
	PS> ./show-lightnings
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

& "$PSScriptRoot/open-default-browser.ps1" "https://www.lightningmaps.org"
exit 0 # success
