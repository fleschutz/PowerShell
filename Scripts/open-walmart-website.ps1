<#
.SYNOPSIS
	Opens the Walmart website
.DESCRIPTION
	This script launches the Web browser with the Walmart website.
.EXAMPLE
	PS> ./open-walmart-website
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/open-default-browser.ps1" "https://www.walmart.com/"
exit 0 # success
