<#
.SYNOPSIS
	Opens the FourSquare website
.DESCRIPTION
	This script launches the Web browser with the FourSquare website.
.EXAMPLE
	PS> ./open-four-square-website
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/open-default-browser.ps1" "https://foursquare.com"
exit 0 # success
