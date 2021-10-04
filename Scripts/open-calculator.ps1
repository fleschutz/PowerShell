<#
.SYNOPSIS
	Starts the calculator application
.DESCRIPTION
	open-calculator.ps1
.EXAMPLE
	PS> ./open-calculator
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

try {
	start-process calc.exe
	exit 0 # success
} catch {
	"⚠️ Error: $($Error[0]) ($($MyInvocation.MyCommand.Name):$($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
