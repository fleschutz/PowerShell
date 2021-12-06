<#
.SYNOPSIS
	Answers to 'good morning'
.DESCRIPTION
	This script says a reply to "good morning" by text-to-speech (TTS).
.EXAMPLE
	PS> ./good-morning
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

$Reply = "Good morning.", "Good morning to you too.", "Well, good morning to you too.", "Good morning! How are you?", "Morning." | Get-Random

& "$PSScriptRoot/give-reply.ps1" "$Reply"
exit 0 # success
