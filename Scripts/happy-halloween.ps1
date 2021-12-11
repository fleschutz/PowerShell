<#
.SYNOPSIS
	Replies to "Happy Halloween"
.DESCRIPTION
	This script replies to 'Happy Halloween' by text-to-speech (TTS).
.EXAMPLE
	PS> ./happy-halloween
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

$Reply = "Happy Halloween to you too!" | Get-Random

& "$PSScriptRoot/give-reply.ps1" "$Reply"
exit 0 # success
