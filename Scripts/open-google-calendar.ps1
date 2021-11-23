<#
.SYNOPSIS
	Opens Google Calendar
.DESCRIPTION
	This script launches the Web browser with the Google Calendar website.
.EXAMPLE
	PS> ./open-google-calendar
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/open-default-browser.ps1" "https://calendar.google.com"
exit 0 # success
