<#
.SYNOPSIS
	Plays a vulture sound
.DESCRIPTION
	This PowerShell script plays a vulture sound.
.EXAMPLE
	PS> ./play-vulture-sound
	(listen and enjoy)
.NOTES
	Author: Markus Fleschutz / License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/play-mp3.ps1" "$PSScriptRoot/../Data/Sounds/vulture.mp3"
exit 0 # success
