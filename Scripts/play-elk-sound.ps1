<#
.SYNOPSIS
	Plays an elk sound
.DESCRIPTION
	This PowerShell script plays an elk sound.
.EXAMPLE
	PS> ./play-elk-sound
	(listen and enjoy)
.NOTES
	Author: Markus Fleschutz / License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/play-mp3.ps1" "$PSScriptRoot/../Data/Sounds/elk.mp3"
exit 0 # success
