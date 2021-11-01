<#
.SYNOPSIS
	Plays a elephant sound
.DESCRIPTION
	This script plays a elephant sound.
.EXAMPLE
	PS> ./play-elephant-sound
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/play-mp3.ps1" "$PSScriptRoot/../Data/Sounds/elephant.mp3"
exit 0 # success
