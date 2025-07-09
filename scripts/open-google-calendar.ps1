<#
.SYNOPSIS
	Opens Google Calendar
.DESCRIPTION
	This PowerShell script launches the Web browser with the Google Calendar website.
.EXAMPLE
	PS> ./open-google-calendar.ps1
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

#requires -version 5.1

& "$PSScriptRoot/open-default-browser.ps1" "https://calendar.google.com"
exit 0 # success
