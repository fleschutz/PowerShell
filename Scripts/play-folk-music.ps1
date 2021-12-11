<#
.SYNOPSIS
	Plays folk music
.DESCRIPTION
	This script launches the Web browser and plays folk music.
.EXAMPLE
	PS> ./play-folk-music
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/open-default-browser.ps1" "http://streema.com/radios/play/Real_Country_96.5_KBDN"
exit 0 # success
