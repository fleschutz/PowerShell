<#
.SYNOPSIS
	Closes the calculator program gracefully
.DESCRIPTION
	close-calculator.ps1 
.EXAMPLE
	PS> ./close-calculator
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/close-program.ps1" "Calculator" "Calculator" "calc"
exit 0 # success
