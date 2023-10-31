<#
.SYNOPSIS
	Plays a lion sound
.DESCRIPTION
	This PowerShell script plays a lion sound.
.EXAMPLE
	PS> ./play-lion-sound
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

& "$PSScriptRoot/play-mp3.ps1" "$PSScriptRoot/../data/sounds/lion.mp3"
exit 0 # success
