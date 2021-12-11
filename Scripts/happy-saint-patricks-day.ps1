<#
.SYNOPSIS
	Replies to "Happy St.Patrick's day"
.DESCRIPTION
	This script replies to 'Happy St.Patrick's day' by text-to-speech (TTS).
.EXAMPLE
	PS> ./happy-saint-patricks-day
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

$Reply = "Happy St.Patrick's day to you too!" | Get-Random

& "$PSScriptRoot/give-reply.ps1" "$Reply"
exit 0 # success
