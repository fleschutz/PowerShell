<#
.SYNOPSIS
	Plays a parrot sound
.DESCRIPTION
	This PowerShell script plays a parrot sound.
.EXAMPLE
	PS> ./play-parrot-sound
	(listen and enjoy)
.NOTES
	Author: Markus Fleschutz / License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/play-mp3.ps1" "$PSScriptRoot/../Data/Sounds/parrot.mp3"
exit 0 # success
