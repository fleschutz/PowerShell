<#
.SYNOPSIS
	Starts the Snipping Tool
.DESCRIPTION
	This script launches the Snipping Tool application.
.EXAMPLE
	PS> ./open-snipping-tool.ps1
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

#requires -version 5.1

Start-Process SnippingTool.exe
exit 0 # success
