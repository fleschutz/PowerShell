<#
.SYNOPSIS
	Replies to "Merry Christmas"
.DESCRIPTION
	This script replies to 'Merry Christmas' by text-to-speech (TTS).
.EXAMPLE
	PS> ./merry-christmas
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

$Reply = "Merry Christmas to you too!", "Happy Christmas to you too!" | Get-Random

& "$PSScriptRoot/give-reply.ps1" "$Reply"
exit 0 # success
