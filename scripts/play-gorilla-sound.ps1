<#
.SYNOPSIS
	Plays a gorilla sound
.DESCRIPTION
	This PowerShell script plays a gorilla sound.
.EXAMPLE
	PS> ./play-gorilla-sound
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

& "$PSScriptRoot/play-mp3.ps1" "$PSScriptRoot/../data/sounds/gorilla.mp3"
exit 0 # success
