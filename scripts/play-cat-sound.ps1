<#
.SYNOPSIS
	Plays a cat sound
.DESCRIPTION
	This PowerShell script plays a cat sound.
.EXAMPLE
	PS> ./play-cat-sound
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

& "$PSScriptRoot/play-mp3.ps1" "$PSScriptRoot/../data/sounds/cat.mp3"
exit 0 # success
