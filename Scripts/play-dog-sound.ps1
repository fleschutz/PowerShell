<#
.SYNOPSIS
	Plays a dog sound
.DESCRIPTION
	This PowerShell script plays a dog sound.
.EXAMPLE
	PS> ./play-dog-sound
.NOTES
	Author: Markus Fleschutz / License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/play-mp3.ps1" "$PSScriptRoot/../Data/Sounds/dog.mp3"
exit 0 # success
