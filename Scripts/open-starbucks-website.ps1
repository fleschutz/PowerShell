<#
.SYNOPSIS
	Opens the Starbucks website
.DESCRIPTION
	This script launches the Web browser with the Starbucks website.
.EXAMPLE
	PS> ./open-starbucks-website
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/open-default-browser.ps1" "https://www.starbucks.com"
exit 0 # success
