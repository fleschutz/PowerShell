<#
.SYNOPSIS
	Plays rock music
.DESCRIPTION
	This script launches the Web browser and plays rock music.
.EXAMPLE
	PS> ./play-rock-music
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/open-default-browser.ps1" "http://streema.com/radios/play/RADIO_BOB_BOBs_Alternative"
exit 0 # success
