<#
.SYNTAX       close-calculator.ps1 
.DESCRIPTION  closes the calculator program gracefully
.LINK         https://github.com/fleschutz/PowerShell
.NOTES        Author: Markus Fleschutz / License: CC0
#>

& "$PSScriptRoot/close-program.ps1" "Calculator" "Calculator" "calc"
exit 0
