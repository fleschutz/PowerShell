<#
.SYNOPSIS
	Opens the UFA website
.DESCRIPTION
	This script launches the Web browser with the UFA website.
.EXAMPLE
	PS> ./open-ufa-website
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/open-default-browser.ps1" "https://www.ufainc.com"
exit 0 # success
