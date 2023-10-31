<#
.SYNOPSIS
	Plays a donkey sound
.DESCRIPTION
	This PowerShell script plays a donkey sound.
.EXAMPLE
	PS> ./play-donkey-sound
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

& "$PSScriptRoot/play-mp3.ps1" "$PSScriptRoot/../data/sounds/donkey.mp3"
exit 0 # success
