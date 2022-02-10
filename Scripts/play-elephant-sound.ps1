<#
.SYNOPSIS
	Plays an elephant sound
.DESCRIPTION
	This PowerShell script plays an elephant sound.
.EXAMPLE
	PS> ./play-elephant-sound
	(listen and enjoy)
.NOTES
	Author: Markus Fleschutz / License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/play-mp3.ps1" "$PSScriptRoot/../Data/Sounds/elephant.mp3"
exit 0 # success
