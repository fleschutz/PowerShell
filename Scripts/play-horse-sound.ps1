<#
.SYNOPSIS
	Plays a horse sound
.DESCRIPTION
	This PowerShell script plays a horse sound.
.EXAMPLE
	PS> ./play-horse-sound
	(listen and enjoy)
.NOTES
	Author: Markus Fleschutz / License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/play-mp3.ps1" "$PSScriptRoot/../Data/Sounds/horse.mp3"
exit 0 # success
