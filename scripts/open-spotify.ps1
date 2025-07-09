<#
.SYNOPSIS
	Launches the Spotify app
.DESCRIPTION
	This script launches the Spotify application.
.EXAMPLE
	PS> ./open-spotify.ps1
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

#requires -version 5.1

Start-Process spotify:
exit 0 # success
