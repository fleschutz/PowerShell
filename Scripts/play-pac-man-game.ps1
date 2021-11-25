<#
.SYNOPSIS
	Plays the Pacman game
.DESCRIPTION
	This script launches the Web browser with the Pacman game.
.EXAMPLE
	PS> ./play-pac-man-game
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/open-default-browser.ps1" "https://bobrov.dev/pacman-pwa/index.html"
exit 0 # success
