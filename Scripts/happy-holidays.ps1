<#
.SYNOPSIS
	Replies to "Happy Holidays"
.DESCRIPTION
	This script replies to 'Happy Holidays' by text-to-speech (TTS).
.EXAMPLE
	PS> ./happy-holidays
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

$Reply = "Happy Holidays to you too!" | Get-Random

& "$PSScriptRoot/give-reply.ps1" "$Reply"
exit 0 # success
