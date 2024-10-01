<#
.SYNOPSIS
	Plays a horse sound
.DESCRIPTION
	This PowerShell script plays a horse sound.
.EXAMPLE
	PS> ./play-horse-sound
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

& "$PSScriptRoot/play-mp3.ps1" "$PSScriptRoot/../data/sounds/horse.mp3"
exit 0 # success
