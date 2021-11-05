<#
.SYNOPSIS
	Plays radio station BOB!
.DESCRIPTION
	This script launches the Web browser and plays radio station BOB!.
.EXAMPLE
	PS> ./play-radio-bob
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/open-browser.ps1" "https://tunein.com/radio/RADIO-BOB-994-s96189/"
exit 0 # success
