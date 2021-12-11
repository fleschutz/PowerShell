<#
.SYNOPSIS
	Replies to "Happy Mother's day"
.DESCRIPTION
	This script replies to 'Happy Mother's day' by text-to-speech (TTS).
.EXAMPLE
	PS> ./happy-mothers-day
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

$Reply = "Happy Mother's day to you too!" | Get-Random

& "$PSScriptRoot/give-reply.ps1" "$Reply"
exit 0 # success
