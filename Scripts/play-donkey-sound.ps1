<#
.SYNOPSIS
	Plays a donkey sound
.DESCRIPTION
	This PowerShell script plays a donkey sound.
.EXAMPLE
	PS> ./play-donkey-sound
.NOTES
	Author: Markus Fleschutz / License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/play-mp3.ps1" "$PSScriptRoot/../Data/Sounds/donkey.mp3"
exit 0 # success
