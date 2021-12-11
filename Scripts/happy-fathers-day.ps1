<#
.SYNOPSIS
	Replies to "Happy Father's day"
.DESCRIPTION
	This script replies to 'Happy Father's day' by text-to-speech (TTS).
.EXAMPLE
	PS> ./happy-fathers-day
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

$Reply = "Happy Father's day to you too!" | Get-Random

& "$PSScriptRoot/give-reply.ps1" "$Reply"
exit 0 # success
