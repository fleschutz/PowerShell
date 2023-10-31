<#
.SYNOPSIS
	Plays a wolf sound
.DESCRIPTION
	This PowerShell script plays a wolf sound.
.EXAMPLE
	PS> ./play-wolf-sound
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

& "$PSScriptRoot/play-mp3.ps1" "$PSScriptRoot/../data/sounds/wolf.mp3"
exit 0 # success
