<#
.SYNOPSIS
	Closes the Notepad app
.DESCRIPTION
	This script closes the Notepad application gracefully.
.EXAMPLE
	PS> ./close-notepad-app
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

TaskKill /im Notepad 
if ($lastExitCode -ne "0") {
	& "$PSScriptRoot/speak-english.ps1" "Sorry, Notepad is already closed."
	exit 1
}
exit 0 # success
