<#
.SYNOPSIS
	Opens Wikipedia's website
.DESCRIPTION
	This script launches the Web browser with Wikipedia's website.
.EXAMPLE
	PS> ./open-wikipedia
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/open-browser.ps1" "https://www.wikipedia.org"
exit 0 # success
