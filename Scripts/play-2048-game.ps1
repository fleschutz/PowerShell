<#
.SYNOPSIS
	Plays the 2048 game
.DESCRIPTION
	This script launches the Web browser with the 2048 game.
.EXAMPLE
	PS> ./play-2048-game
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/open-default-browser.ps1" "https://2048game.com/"
exit 0 # success
