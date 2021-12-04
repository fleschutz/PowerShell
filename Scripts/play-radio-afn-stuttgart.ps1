<#
.SYNOPSIS
	Plays radio AFN Stuttgart
.DESCRIPTION
	This script launches the Web browser and plays radio station AFN Stuttgart.
.EXAMPLE
	PS> ./play-radio-afn-stuttgart
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/open-default-browser.ps1" "https://www.afneurope.net/Portals/100/360/minimalplayer2.html#AFNE_STU"
exit 0 # success
