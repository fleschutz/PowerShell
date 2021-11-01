<#
.SYNOPSIS
	Plays a gorilla sound
.DESCRIPTION
	This script plays a gorilla sound.
.EXAMPLE
	PS> ./play-gorilla-sound
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/play-mp3.ps1" "$PSScriptRoot/../Data/Sounds/gorilla.mp3"
exit 0 # success
