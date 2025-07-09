<#
.SYNOPSIS
	Launches Windows Defender
.DESCRIPTION
	This script launches the Windows Defender application.
.EXAMPLE
	PS> ./open-windows-defender.ps1
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

#requires -version 5.1

Start-Process windowsdefender:
exit 0 # success
