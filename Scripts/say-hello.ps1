<#
.SYNOPSIS
	Replies to "Say hello"
.DESCRIPTION
	This script replies to "Say hello" by text-to-speech (TTS).
.EXAMPLE
	PS> ./say-hello
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/give-reply.ps1" "Hello everyone."
exit 0 # success

