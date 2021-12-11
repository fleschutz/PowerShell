<#
.SYNOPSIS
	Plays dance music
.DESCRIPTION
	This script launches the Web browser and plays dance music.
.EXAMPLE
	PS> ./play-dance-music
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/open-default-browser.ps1" "http://streema.com/radios/play/D100_Radio"
exit 0 # success
