<#
.SYNOPSIS
	Plays a parrot sound
.DESCRIPTION
	This PowerShell script plays a parrot sound.
.EXAMPLE
	PS> ./play-parrot-sound
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

& "$PSScriptRoot/play-mp3.ps1" "$PSScriptRoot/../data/sounds/parrot.mp3"
exit 0 # success
