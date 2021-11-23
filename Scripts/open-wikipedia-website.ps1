<#
.SYNOPSIS
	Opens the Wikipedia website
.DESCRIPTION
	This script launches the Web browser with the Wikipedia website.
.EXAMPLE
	PS> ./open-wikipedia-website
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/open-default-browser.ps1" "https://www.wikipedia.org"
exit 0 # success
