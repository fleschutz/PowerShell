<#
.SYNOPSIS
	Repeats the last reply
.DESCRIPTION
	This PowerShell script repeats the last reply by text-to-speech (TTS).
.EXAMPLE
	PS> ./repeat-last-reply
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz / License: CC0
#>

function GetTempDir {
	if ("$env:TEMP" -ne "")	{ return "$env:TEMP" }
	if ("$env:TMP" -ne "")	{ return "$env:TMP" }
	if ($IsLinux) { return "/tmp" }
	return "C:\Temp"
}

if (test-path "$(GetTempDir)/last_reply_given.txt" -pathType leaf) {
	$Reply = "It was: "
	$Reply += Get-Content "$(GetTempDir)/last_reply_given.txt"
} else {
	$Reply = "Sorry, I can't remember."
}

& "$PSScriptRoot/give-reply.ps1" "$Reply"
exit 0 # success
