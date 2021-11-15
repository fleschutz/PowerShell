<#
.SYNOPSIS
	Closes OBS Studio
.DESCRIPTION
	This script closes the OBS Studio application gracefully.
.EXAMPLE
	PS> ./close-obs-studio
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

$result = TaskKill /im obs64.exe
if ($result -ne 0) {
	& "$PSScriptRoot/speak-english.ps1" "Sorry, can't close OBS Studio"
	exit 1
}
exit 0 # success
