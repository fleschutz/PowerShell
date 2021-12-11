<#
.SYNOPSIS
	Replies to "Happy Hanukkah"
.DESCRIPTION
	This script replies to 'Happy Hanukkah' by text-to-speech (TTS).
.EXAMPLE
	PS> ./happy-hanukkah
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

$Reply = "Happy Hanukkah to you too!" | Get-Random

& "$PSScriptRoot/give-reply.ps1" "$Reply"
exit 0 # success
