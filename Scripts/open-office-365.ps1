<#
.SYNOPSIS
	Opens Microsoft Office 365
.DESCRIPTION
	This script launches the Web browser with the Microsoft Office 365 website.
.EXAMPLE
	PS> ./open-office-365
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/open-default-browser.ps1" "https://portal.office.com"
exit 0 # success
