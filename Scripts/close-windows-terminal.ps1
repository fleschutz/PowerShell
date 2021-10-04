<#
.SYNOPSIS
	close-windows-terminal.ps1 
.DESCRIPTION
	Closes the Windows Terminal application
.EXAMPLE
	PS> ./close-windows-terminal
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/close-program.ps1" "Windows Terminal" "WindowsTerminal" "WindowsTerminal"
exit 0 # success
