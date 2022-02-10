<#
.SYNOPSIS
	Plays a bee sound
.DESCRIPTION
	This PowerShell script plays a bee sound.
.EXAMPLE
	PS> ./play-bee-sound
	(listen and enjoy)
.NOTES
	Author: Markus Fleschutz / License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/play-mp3.ps1" "$PSScriptRoot/../Data/Sounds/bee.mp3"
exit 0 # success
