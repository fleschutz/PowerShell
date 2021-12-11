<#
.SYNOPSIS
	Replies to "Sorry"
.DESCRIPTION
	This script replies to 'Sorry' by text-to-speech (TTS).
.EXAMPLE
	PS> ./sorry
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

$Reply = "Never mind." | Get-Random

& "$PSScriptRoot/give-reply.ps1" "$Reply"
exit 0 # success
