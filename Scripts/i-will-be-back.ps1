<#
.SYNOPSIS
	Replies to 'I'll be back'
.DESCRIPTION
	This script replies to "I'll be back" by text-to-speech (TTS).
.EXAMPLE
	PS> ./i-will-be-back
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

$Reply = "Hasta la vista, baby."

& "$PSScriptRoot/give-reply.ps1" "$Reply"
exit 0 # success
