<#
.SYNOPSIS
	Opens the CIA website
.DESCRIPTION
	This script launches the Web browser with the CIA website (Central Intelligence Agency).
.EXAMPLE
	PS> ./open-cia-website
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/open-default-browser.ps1" "https://www.cia.gov/"
exit 0 # success
