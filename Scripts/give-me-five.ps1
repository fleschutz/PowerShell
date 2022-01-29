<#
.SYNOPSIS
	Replies to "Give me five"
.DESCRIPTION
	This PowerShell script replies to 'Give me five' by text-to-speech (TTS).
.EXAMPLE
	PS> ./give-me-five
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz / License: CC0
#>

$Reply = "Thanks!", "Hi five.", "Hi five to all of yours.", "Four plus one.", "Three plus two." | Get-Random

& "$PSScriptRoot/give-reply.ps1" "$Reply"
exit 0 # success
