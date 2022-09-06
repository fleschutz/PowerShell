<#
.SYNOPSIS
	Launches the Spotify app
.DESCRIPTION
	This script launches the Spotify application.
.EXAMPLE
	PS> ./open-spotify
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

Start-Process spotify:
exit 0 # success
