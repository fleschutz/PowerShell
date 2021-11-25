<#
.SYNOPSIS
	Plays the Chess game
.DESCRIPTION
	This script launches the Web browser with the Chess game.
.EXAMPLE
	PS> ./play-chess-game
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/open-default-browser.ps1" "https://www.chess.com/"
exit 0 # success
