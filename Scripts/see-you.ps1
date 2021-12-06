<#
.SYNOPSIS
	Answers to 'see you'
.DESCRIPTION
	This script says a reply to "see you" by text-to-speech (TTS).
.EXAMPLE
	PS> ./see-you
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

$Reply = "Good bye.", "See you.", "Bye bye." | Get-Random

& "$PSScriptRoot/give-reply.ps1" "$Reply"
exit 0 # success
