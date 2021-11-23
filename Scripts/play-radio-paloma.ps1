<#
.SYNOPSIS
	Plays radio station Paloma
.DESCRIPTION
	This script launches the Web browser and plays radio station Paloma.
.EXAMPLE
	PS> ./play-radio-paloma
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/open-default-browser.ps1" "https://tunein.com/radio/Radio-Paloma-s97169/"
exit 0 # success
