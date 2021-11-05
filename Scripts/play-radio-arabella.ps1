<#
.SYNOPSIS
	Plays radio station Arabella
.DESCRIPTION
	This script launches the Web browser and plays radio station Arabella.
.EXAMPLE
	PS> ./play-radio-arabella
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/open-browser.ps1" "https://tunein.com/radio/Radio-Arabella-Mnchen-1052-s119032/"
exit 0 # success
