<#
.SYNOPSIS
	play-beep.ps1
.DESCRIPTION
	Plays a beep sound
.EXAMPLE
	PS> .\play-beep.ps1
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz / License: CC0
#>

[console]::beep(500,300)
exit 0
