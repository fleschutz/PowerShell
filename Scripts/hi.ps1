<#
.SYNOPSIS
	Replies to "Hi"
.DESCRIPTION
	This script replies to 'Hi' by text-to-speech (TTS).
.EXAMPLE
	PS> ./hi
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

$Reply = "Hello, how can I help?"

& "$PSScriptRoot/give-reply.ps1" "$Reply"
exit 0 # success
