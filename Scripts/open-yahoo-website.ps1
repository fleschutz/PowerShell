<#
.SYNOPSIS
	Opens the Yahoo website
.DESCRIPTION
	This script launches the Web browser with the Yahoo website.
.EXAMPLE
	PS> ./open-yahoo-website
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/open-default-browser.ps1" "https://www.yahoo.com"
exit 0 # success
