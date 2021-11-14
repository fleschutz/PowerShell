<#
.SYNOPSIS
	Closes the calculator app
.DESCRIPTION
	This script closes the calculator application gracefully.
.EXAMPLE
	PS> ./close-calculator
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

try {
	taskkill /im "Calculator.exe" /f /t
	exit 0 # success
} catch {
	& "$PSScriptRoot/speak-english.ps1" "Sorry, calculator isn't running"
	exit 1
}
