<#
.SYNOPSIS
	Opens the HolidayCheck website
.DESCRIPTION
	This script launches the Web browser with the HolidayCheck website.
.EXAMPLE
	PS> ./open-holiday-check-website
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/open-default-browser.ps1" "https://www.holidaycheck.com"
exit 0 # success
