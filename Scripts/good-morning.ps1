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

$Answer = "Good morning.", "Good morning to you too.", "Well, good morning to you too.", "Good morning! How are you?", "Morning." | Get-Random

write-output "$Answer"
& "$PSScriptRoot/speak-english.ps1" "$Answer"
exit 0 # success
