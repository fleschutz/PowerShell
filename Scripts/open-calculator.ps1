<#
.SYNOPSIS
	open-calculator.ps1
.DESCRIPTION
	Starts the calculator program.
.EXAMPLE
	PS> .\open-calculator.ps1 
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

try {
	start-process calc.exe
	exit 0
} catch {
	write-error "⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
