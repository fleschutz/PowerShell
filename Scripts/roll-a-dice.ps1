<#
.SYNOPSIS
	Replies to "Roll a dice"
.DESCRIPTION
	This script rolls a dice and returns the number by text-to-speech (TTS).
.EXAMPLE
	PS> ./roll-a-dice
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

$Reply = "One.", "Two.", "Three.", "Four.", "Five.", "Six." | Get-Random

& "$PSScriptRoot/give-reply.ps1" "$Reply"
exit 0 # success
