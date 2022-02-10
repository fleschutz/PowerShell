<#
.SYNOPSIS
	Plays a cat sound
.DESCRIPTION
	This PowerShell script plays a cat sound.
.EXAMPLE
	PS> ./play-cat-sound
.NOTES
	Author: Markus Fleschutz / License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/play-mp3.ps1" "$PSScriptRoot/../Data/Sounds/cat.mp3"
exit 0 # success
