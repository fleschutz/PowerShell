<#
.SYNOPSIS
	Plays jazz music
.DESCRIPTION
	This script launches the Web browser and plays jazz music.
.EXAMPLE
	PS> ./play-jazz-music
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/open-default-browser.ps1" "http://streema.com/radios/play/KLEB"
exit 0 # success
