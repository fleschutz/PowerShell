<#
.SYNOPSIS
	Closes Visual Studio
.DESCRIPTION
	This script closes the Microsoft Visual Studio application gracefully.
.EXAMPLE
	PS> ./close-visual-studio
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

$result = TaskKill /im devenv.exe
if ($result -ne 0) {
	& "$PSScriptRoot/speak-english.ps1" "Sorry, can't close Visual Studio"
	exit 1
}
exit 0 # success
