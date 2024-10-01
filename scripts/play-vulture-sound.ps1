<#
.SYNOPSIS
	Plays a vulture sound
.DESCRIPTION
	This PowerShell script plays a vulture sound.
.EXAMPLE
	PS> ./play-vulture-sound
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

& "$PSScriptRoot/play-mp3.ps1" "$PSScriptRoot/../data/sounds/vulture.mp3"
exit 0 # success
