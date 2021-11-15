<#
.SYNOPSIS
	Closes Git Extensions
.DESCRIPTION
	This script closes the Git Extensions application gracefully.
.EXAMPLE
	PS> ./close-git-extensions
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

$result = TaskKill /im GitExtensions.exe
if ($result -ne 0) {
	& "$PSScriptRoot/speak-english.ps1" "Sorry, can't close Git Extensions"
	exit 1
}
exit 0 # success
