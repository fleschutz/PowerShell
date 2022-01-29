<#
.SYNOPSIS
	Closes the Microsoft Paint app 
.DESCRIPTION
	This PowerShell script closes the Microsoft Paint application gracefully.
.EXAMPLE
	PS> ./close-microsoft-paint
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz / License: CC0
#>

TaskKill /im mspaint.exe
if ($lastExitCode -ne "0") {
	& "$PSScriptRoot/give-reply.ps1" "Sorry, Microsoft Paint isn't running."
	exit 1
}
exit 0 # success
