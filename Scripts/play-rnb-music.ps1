<#
.SYNOPSIS
	Plays RnB music
.DESCRIPTION
	This script launches the Web browser and plays RnB music.
.EXAMPLE
	PS> ./play-rnb-music
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/open-default-browser.ps1" "http://streema.com/radios/play/Biker_Valley_Radio_2"
exit 0 # success
