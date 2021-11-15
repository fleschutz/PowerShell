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

TaskKill /im Calculator.exe /f /t
if ($lastExitCode -ne "0") {
	& "$PSScriptRoot/speak-english.ps1" "Sorry, can't close calculator"
	exit 1
}
exit 0 # success
