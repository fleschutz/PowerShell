<#
.SYNOPSIS
	Plays the Tower game
.DESCRIPTION
	This script launches the Web browser with the Tower game.
.EXAMPLE
	PS> ./play-tower-game
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/open-default-browser.ps1" "https://www.towergame.app/"
exit 0 # success
