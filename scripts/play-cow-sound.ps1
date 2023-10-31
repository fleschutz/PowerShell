<#
.SYNOPSIS
	Plays a cow sound
.DESCRIPTION
	This PowerShell script plays a cow sound.
.EXAMPLE
	PS> ./play-cow-sound
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

& "$PSScriptRoot/play-mp3.ps1" "$PSScriptRoot/../data/sounds/cow.mp3"
exit 0 # success
