<#
.SYNOPSIS
	Plays a goat sound
.DESCRIPTION
	This PowerShell script plays a goat sound.
.EXAMPLE
	PS> ./play-goat-sound
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

& "$PSScriptRoot/play-mp3.ps1" "$PSScriptRoot/../data/sounds/goat.mp3"
exit 0 # success
