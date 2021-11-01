<#
.SYNOPSIS
	Plays a wulf sound
.DESCRIPTION
	This script plays a wulf sound.
.EXAMPLE
	PS> ./play-wulf-sound
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/play-mp3.ps1" "$PSScriptRoot/../Data/Sounds/wulf.mp3"
exit 0 # success
