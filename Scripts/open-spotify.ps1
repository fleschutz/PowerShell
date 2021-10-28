<#
.SYNOPSIS
	Starts Spotify 
.DESCRIPTION
	This script launches the Spotify application.
.EXAMPLE
	PS> ./open-spotify
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

Start-Process spotify.exe
exit 0 # success
