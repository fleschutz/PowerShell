<#
.SYNOPSIS
	Launches the calculator application
.DESCRIPTION
	This PowerShell script launches the calculator application.
.EXAMPLE
	PS> ./open-calculator
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz / License: CC0
#>

try {
	start-process ms-calculator:
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
