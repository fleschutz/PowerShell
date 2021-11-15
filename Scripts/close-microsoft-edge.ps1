<#
.SYNOPSIS
	Closes Microsoft Edge
.DESCRIPTION
	This script closes the Microsoft Edge Web browser gracefully.
.EXAMPLE
	PS> ./close-microsoft-edge
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

$result = TaskKill /im msedge.exe
if ($result -ne 0) {
	& "$PSScriptRoot/speak-english.ps1" "Sorry, can't close Microsoft Edge"
	exit 1
}
exit 0 # success
