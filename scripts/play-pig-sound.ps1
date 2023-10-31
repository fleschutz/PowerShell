<#
.SYNOPSIS
	Plays a pig sound
.DESCRIPTION
	This PowerShell script plays a pig sound.
.EXAMPLE
	PS> ./play-pig-sound
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

& "$PSScriptRoot/play-mp3.ps1" "$PSScriptRoot/../data/sounds/pig.mp3"
exit 0 # success
