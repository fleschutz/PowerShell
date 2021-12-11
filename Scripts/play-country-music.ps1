<#
.SYNOPSIS
	Plays country music
.DESCRIPTION
	This script launches the Web browser and plays country music.
.EXAMPLE
	PS> ./play-country-music
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/open-default-browser.ps1" "http://streema.com/radios/play/HPR1_The_Classic_Country_Channel"
exit 0 # success
