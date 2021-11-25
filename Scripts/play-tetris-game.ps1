<#
.SYNOPSIS
	Plays the Tetris game
.DESCRIPTION
	This script launches the Web browser with the Tetris game.
.EXAMPLE
	PS> ./play-tetris-game
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/open-default-browser.ps1" "https://www.goodoldtetris.com/"
exit 0 # success
