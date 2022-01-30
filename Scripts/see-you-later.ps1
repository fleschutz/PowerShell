<#
.SYNOPSIS
	Answers to 'see you later'
.DESCRIPTION
	This PowerShell script says a reply to "see you later" by text-to-speech (TTS).
.EXAMPLE
	PS> ./see-you-later
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz / License: CC0
#>

$Reply = "Good bye.", "See you.", "Bye bye." | Get-Random

& "$PSScriptRoot/give-reply.ps1" "$Reply"
exit 0 # success
