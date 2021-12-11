<#
.SYNOPSIS
	Replies to "Happy New Year"
.DESCRIPTION
	This script replies to 'Happy New Year' by text-to-speech (TTS).
.EXAMPLE
	PS> ./happy-new-year
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

$Reply = "Thank you. Happy New Year to you too!" | Get-Random

& "$PSScriptRoot/give-reply.ps1" "$Reply"
exit 0 # success
