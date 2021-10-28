<#
.SYNOPSIS
	Starts the Snipping Tool
.DESCRIPTION
	This script launches the Snipping Tool application.
.EXAMPLE
	PS> ./open-snipping-tool
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

Start-Process SnippingTool.exe
exit 0 # success
