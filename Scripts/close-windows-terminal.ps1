<#
.SYNOPSIS
	Closes the Windows Terminal app
.DESCRIPTION
	This script closes the Windows Terminal application gracefully.
.EXAMPLE
	PS> ./close-windows-terminal
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/close-program.ps1" "Windows Terminal" "WindowsTerminal" "WindowsTerminal"
exit 0 # success
