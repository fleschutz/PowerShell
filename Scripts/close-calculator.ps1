<#
.SYNOPSIS
	Closes the calculator application
.DESCRIPTION
	This PowerShell script closes the calculator application gracefully.
.EXAMPLE
	PS> ./close-calculator
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz / License: CC0
#>

TaskKill /im Calculator.exe /f /t
if ($lastExitCode -ne "0") {
	& "$PSScriptRoot/give-reply.ps1" "Sorry, calculator isn't running."
	exit 1
}
exit 0 # success
