<#
.SYNOPSIS
	Opens Google Earth
.DESCRIPTION
	This script launches the Web browser with the Google Earth website.
.EXAMPLE
	PS> ./open-google-earth
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/open-default-browser.ps1" "https://earth.google.com/web/"
exit 0 # success
