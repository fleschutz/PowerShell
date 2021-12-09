<#
.SYNOPSIS
	Repeats the last reply
.DESCRIPTION
	This repeats the last reply by text-to-speech (TTS).
.EXAMPLE
	PS> ./repeat-last-reply
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

if (test-path "$env:TEMP/last_reply.txt" -pathType leaf) {
	$Reply = "It was: "
	$Reply += Get-Content "$env:TEMP/.last_reply.txt"
} else {
	$Reply = "Sorry, I can't remember."
}

& "$PSScriptRoot/give-reply.ps1" "$Reply"
exit 0 # success
