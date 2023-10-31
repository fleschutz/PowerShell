<#
.SYNOPSIS
	Plays a dog sound
.DESCRIPTION
	This PowerShell script plays a dog sound.
.EXAMPLE
	PS> ./play-dog-sound
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

& "$PSScriptRoot/play-mp3.ps1" "$PSScriptRoot/../data/sounds/dog.mp3"
exit 0 # success
