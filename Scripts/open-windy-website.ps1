<#
.SYNOPSIS
	Opens the windy.com website
.DESCRIPTION
	This script launches the Web browser with the windy.com website.
.EXAMPLE
	PS> ./open-windy-website
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/open-default-browser.ps1" "https://www.windy.com"
exit 0 # success
