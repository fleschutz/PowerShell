<#
.SYNOPSIS
	Opens the FBI website
.DESCRIPTION
	This script launches the Web browser with the FBI website.
.EXAMPLE
	PS> ./open-fbi-website
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/open-browser.ps1" "https://www.fbi.gov"
exit 0 # success
