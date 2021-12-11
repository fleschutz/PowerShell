<#
.SYNOPSIS
	Plays indie music
.DESCRIPTION
	This script launches the Web browser and plays indie music.
.EXAMPLE
	PS> ./play-indie-music
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/open-default-browser.ps1" "http://streema.com/radios/play/Prog_Rock"
exit 0 # success
