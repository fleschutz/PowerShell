<#
.SYNOPSIS
	Opens Toggl Track
.DESCRIPTION
	This script launches the Web browser with the Toggl Track website.
.EXAMPLE
	PS> ./open-toggl-website
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/open-default-browser.ps1" "https://track.toggl.com"
exit 0 # success
