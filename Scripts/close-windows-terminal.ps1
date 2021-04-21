<#
.SYNTAX       close-windows-terminal.ps1 
.DESCRIPTION  closes Windows Terminal gracefully
.LINK         https://github.com/fleschutz/PowerShell
.NOTES        Author: Markus Fleschutz / License: CC0
#>

& "$PSScriptRoot/close-program.ps1" "Windows Terminal" "WindowsTerminal" "WindowsTerminal"
exit 0
