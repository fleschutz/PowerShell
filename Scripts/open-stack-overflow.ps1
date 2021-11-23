<#
.SYNOPSIS
	Opens the Stack Overflow website
.DESCRIPTION
	This script launches the Web browser with the Stack Overflow website.
.EXAMPLE
	PS> ./open-stack-overflow
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/open-default-browser.ps1" "https://stackoverflow.com"
exit 0 # success
