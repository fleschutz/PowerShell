<#
.SYNOPSIS
	Opens the White House website 
.DESCRIPTION
	This script launches the Web browser with the White House website.
.EXAMPLE
	PS> ./open-white-house
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/open-browser.ps1" "https://www.whitehouse.gov"
exit 0 # success
