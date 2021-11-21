<#
.SYNOPSIS
	Closes the Git Extensions app
.DESCRIPTION
	This script closes the Git Extensions application gracefully.
.EXAMPLE
	PS> ./close-git-extensions-app
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

TaskKill /im GitExtensions.exe
if ($lastExitCode -ne "0") {
	& "$PSScriptRoot/speak-english.ps1" "Sorry, can't close Git Extensions"
	exit 1
}
exit 0 # success
