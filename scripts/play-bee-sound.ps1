<#
.SYNOPSIS
	Plays a bee sound
.DESCRIPTION
	This PowerShell script plays a bee sound.
.EXAMPLE
	PS> ./play-bee-sound
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

& "$PSScriptRoot/play-mp3.ps1" "$PSScriptRoot/../data/sounds/bee.mp3"
exit 0 # success
