<#
.SYNOPSIS
	Replies to "Happy Ramadan"
.DESCRIPTION
	This script replies to 'Happy Ramadan' by text-to-speech (TTS).
.EXAMPLE
	PS> ./happy-ramadan
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

$Reply = "Happy Ramadan to you too!" | Get-Random

& "$PSScriptRoot/give-reply.ps1" "$Reply"
exit 0 # success
