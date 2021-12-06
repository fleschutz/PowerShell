<#
.SYNOPSIS
	Replies to 'good evening'
.DESCRIPTION
	This script says a reply to 'good evening' by text-to-speech (TTS).
.EXAMPLE
	PS> ./good-evening
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

$Reply = "And a special good evening to you too."

& "$PSScriptRoot/give-reply.ps1" "$Reply"
exit 0 # success
