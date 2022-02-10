<#
.SYNOPSIS
	Plays a lion sound
.DESCRIPTION
	This PowerShell script plays a lion sound.
.EXAMPLE
	PS> ./play-lion-sound
	(listen and enjoy)
.NOTES
	Author: Markus Fleschutz / License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/play-mp3.ps1" "$PSScriptRoot/../Data/Sounds/lion.mp3"
exit 0 # success
