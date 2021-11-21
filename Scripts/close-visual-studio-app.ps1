<#
.SYNOPSIS
	Closes the Visual Studio app
.DESCRIPTION
	This script closes the Microsoft Visual Studio application gracefully.
.EXAMPLE
	PS> ./close-visual-studio-app
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

TaskKill /im devenv.exe
if ($lastExitCode -ne "0") {
	& "$PSScriptRoot/speak-english.ps1" "Sorry, can't close Visual Studio"
	exit 1
}
exit 0 # success
