<#
.SYNOPSIS
	Plays an elephant sound
.DESCRIPTION
	This PowerShell script plays an elephant sound.
.EXAMPLE
	PS> ./play-elephant-sound
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

& "$PSScriptRoot/play-mp3.ps1" "$PSScriptRoot/../data/sounds/elephant.mp3"
exit 0 # success
