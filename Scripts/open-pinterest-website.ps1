<#
.SYNOPSIS
	Opens the Pinterest website
.DESCRIPTION
	This script launches the Web browser with the Pinterest website.
.EXAMPLE
	PS> ./open-pinterest-website
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/open-default-browser.ps1" "https://www.pinterest.com"
exit 0 # success
