<#
.SYNOPSIS
	Opens the Stack Overflow website
.DESCRIPTION
	This script launches the Web browser with the Stack Overflow website.
.EXAMPLE
	PS> ./open-stack-overflow.ps1
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

#requires -version 5.1

& "$PSScriptRoot/open-default-browser.ps1" "https://stackoverflow.com"
exit 0 # success
