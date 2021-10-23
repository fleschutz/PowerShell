<#
.SYNOPSIS
	Closes the Snipping Tool
.DESCRIPTION
	This script closes the Snipping Tool application gracefully.
.EXAMPLE
	PS> ./close-snipping-tool
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/close-program.ps1" "Snipping Tool" "SnippingTool.exe" ""
exit 0 # success
