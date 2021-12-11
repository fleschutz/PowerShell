<#
.SYNOPSIS
	Replies to "Happy Valentine's day"
.DESCRIPTION
	This script replies to 'Happy Valentine's day' by text-to-speech (TTS).
.EXAMPLE
	PS> ./happy-valentines-day
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

$Reply = "Happy Valentine's day to you too!" | Get-Random

& "$PSScriptRoot/give-reply.ps1" "$Reply"
exit 0 # success
