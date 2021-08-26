<#
.SYNOPSIS
	close-calculator.ps1 
.DESCRIPTION
	Closes the calculator program gracefully
.EXAMPLE
	PS> .\close-calculator.ps1
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author:  Markus Fleschutz
	License: CC0
#>

& "$PSScriptRoot/close-program.ps1" "Calculator" "Calculator" "calc"
exit 0
