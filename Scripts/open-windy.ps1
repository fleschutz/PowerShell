<#
.SYNOPSIS
	Opens windy.com
.DESCRIPTION
	This script launches the Web browser with the windy.com website.
.EXAMPLE
	PS> ./open-windy
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/open-browser.ps1" "https://www.windy.com"
exit 0 # success
