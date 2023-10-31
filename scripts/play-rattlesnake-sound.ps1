<#
.SYNOPSIS
	Plays a rattlesnake sound
.DESCRIPTION
	This PowerShell script plays a rattlesnake sound.
.EXAMPLE
	PS> ./play-rattlesnake-sound
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

& "$PSScriptRoot/play-mp3.ps1" "$PSScriptRoot/../data/sounds/rattlesnake.mp3"
exit 0 # success
