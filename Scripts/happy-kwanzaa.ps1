<#
.SYNOPSIS
	Replies to "Happy Kwanzaa"
.DESCRIPTION
	This script replies to 'Happy Kwanzaa' by text-to-speech (TTS).
.EXAMPLE
	PS> ./happy-kwanzaa
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

$Reply = "Happy Kwanzaa to you too!" | Get-Random

& "$PSScriptRoot/give-reply.ps1" "$Reply"
exit 0 # success
