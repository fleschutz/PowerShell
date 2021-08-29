<#
.SYNOPSIS
	close-windows-terminal.ps1 
.DESCRIPTION
	Closes Windows Terminal gracefully.
.EXAMPLE
	PS> .\close-windows-terminal.ps1
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/close-program.ps1" "Windows Terminal" "WindowsTerminal" "WindowsTerminal"
exit 0
