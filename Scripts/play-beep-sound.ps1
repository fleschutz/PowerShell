<#
.SYNOPSIS
	Plays a short beep sound
.DESCRIPTION
	This PowerShell script plays a short beep sound.
.EXAMPLE
	PS> ./play-beep-sound
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

[System.Console]::Beep(500,300)
start-sleep -m 300
exit 0 # success
