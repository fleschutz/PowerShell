<#
.SYNOPSIS
	Plays a frog sound
.DESCRIPTION
	This PowerShell script plays a frog sound.
.EXAMPLE
	PS> ./play-frog-sound
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

& "$PSScriptRoot/play-mp3.ps1" "$PSScriptRoot/../data/sounds/frog.mp3"
exit 0 # success
