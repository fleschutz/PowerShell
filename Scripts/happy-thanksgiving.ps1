<#
.SYNOPSIS
	Replies to "Happy Thanksgiving"
.DESCRIPTION
	This script replies to 'Happy Thanksgiving' by text-to-speech (TTS).
.EXAMPLE
	PS> ./happy-thanksgiving
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

$Reply = "Happy Thanksgiving to you too!" | Get-Random

& "$PSScriptRoot/give-reply.ps1" "$Reply"
exit 0 # success
