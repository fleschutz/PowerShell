<#
.SYNOPSIS
	Plays the TicTacToe game
.DESCRIPTION
	This script launches the Web browser with the TicTacToe game.
.EXAMPLE
	PS> ./play-tic-tac-toe-game
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/open-default-browser.ps1" "https://tmaiadev-tictactoe.netlify.app/"
exit 0 # success
