<#
.SYNOPSIS
	Opens Google Stadia
.DESCRIPTION
	This script launches the Web browser with the Google Stadia website.
.EXAMPLE
	PS> ./open-google-stadia
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/open-default-browser.ps1" "https://stadia.google.com"
exit 0 # success
