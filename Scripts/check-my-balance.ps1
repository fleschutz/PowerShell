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

& "$PSScriptRoot/give-reply.ps1" "OK, what's your account number?"
exit 0 # success
