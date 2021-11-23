<#
.SYNOPSIS
	Plays radio station Ibiza
.DESCRIPTION
	This script launches the Web browser and plays radio station Ibiza.
.EXAMPLE
	PS> ./play-radio-ibiza
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/open-default-browser.ps1" "https://tunein.com/radio/Ibiza-Live-Radio-s203278/"
exit 0 # success
