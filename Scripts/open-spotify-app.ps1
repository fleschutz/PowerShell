<#
.SYNOPSIS
	Launches the Spotify app
.DESCRIPTION
	This script launches the Spotify application.
.EXAMPLE
	PS> ./open-spotify-app
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

Start-Process spotify:
exit 0 # success
