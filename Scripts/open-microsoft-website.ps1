<#
.SYNOPSIS
	Opens the Microsoft website
.DESCRIPTION
	This script launches the Web browser with the Microsoft website.
.EXAMPLE
	PS> ./open-microsoft-website
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/open-default-browser.ps1" "https://www.microsoft.com/"
exit 0 # success
