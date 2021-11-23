<#
.SYNOPSIS
	Opens the BBC website
.DESCRIPTION
	This script launches the Web browser with the BBC website.
.EXAMPLE
	PS> ./open-bbc-website
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/open-default-browser.ps1" "https://www.bbc.com"
exit 0 # success
