<#
.SYNOPSIS
	Replies to 'thank you'
.DESCRIPTION
	This script replies to 'thank you' by text-to-speech (TTS).
.EXAMPLE
	PS> ./thank-you
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

$Reply = "It's a pleasure.", "Never mind.", "Pleasure is mine." | Get-Random

& "$PSScriptRoot/give-reply.ps1" "$Reply"
exit 0 # success
