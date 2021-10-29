<#
.SYNOPSIS
	Opens the slashdot website
.DESCRIPTION
	This script launches the Web browser with the slashdot.org website.
.EXAMPLE
	PS> ./open-slash-dot
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/open-browser.ps1" "https://slashdot.org"
exit 0 # success
