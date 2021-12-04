<#
.SYNOPSIS
	Checks the balance (fun)
.DESCRIPTION
	This script checks the balance and replies by text-to-speech (TTS).
.EXAMPLE
	PS> ./check-my-balance
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

try {
	$Reply = "OK, what's your account number?"
	"✔️ $Reply"
	& "$PSScriptRoot/speak-english.ps1" "$Reply"
	exit 0 # success
} catch {
	"⚠️ Error: $($Error[0]) ($($MyInvocation.MyCommand.Name):$($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
