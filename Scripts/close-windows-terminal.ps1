<#
.SYNOPSIS
	close-windows-terminal.ps1 
.DESCRIPTION
	Closes Windows Terminal gracefully
.EXAMPLE
	PS> .\close-windows-terminal.ps1
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author:  Markus Fleschutz
	License: CC0
#>

& "$PSScriptRoot/close-program.ps1" "Windows Terminal" "WindowsTerminal" "WindowsTerminal"
exit 0
