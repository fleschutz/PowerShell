<#
.SYNOPSIS
	Say an answer to 'good morning'
.DESCRIPTION
	This script answers "good morning" by text-to-speech (TTS).
.EXAMPLE
	PS> ./good-morning
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

$Answer = "Well, good morning to you too."

write-output "$Answer"
& "$PSScriptRoot/speak-english.ps1" "$Answer"
exit 0 # success
