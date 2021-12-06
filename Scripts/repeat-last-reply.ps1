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

if (test-path "$HOME/.last_reply.txt" -pathType leaft) {
	$Reply = "OK, I said: "
	$Reply += Get-Content "$HOME/.last_reply.txt"
} else {
	$Reply = "Sorry, I can't remember."
}

& "$PSScriptRoot/give-reply.ps1" "$Reply"
exit 0 # success
