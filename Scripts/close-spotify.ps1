<#
.SYNOPSIS
	Closes the Spotify app
.DESCRIPTION
	This PowerShell script closes the Spotify application gracefully.
.EXAMPLE
	PS> ./close-spotify
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz / License: CC0
#>

& "$PSScriptRoot/close-program.ps1" "Spotify" "spotify" ""
exit 0 # success
