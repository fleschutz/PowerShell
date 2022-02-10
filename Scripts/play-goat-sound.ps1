<#
.SYNOPSIS
	Plays a goat sound
.DESCRIPTION
	This PowerShell script plays a goat sound.
.EXAMPLE
	PS> ./play-goat-sound
	(listen and enjoy)
.NOTES
	Author: Markus Fleschutz / License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/play-mp3.ps1" "$PSScriptRoot/../Data/Sounds/goat.mp3"
exit 0 # success
