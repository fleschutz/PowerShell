<#
.SYNOPSIS
	play-beep.ps1
.DESCRIPTION
	Plays a short beep sound
.EXAMPLE
	PS> ./play-beep
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

[console]::beep(500,300)
exit 0
