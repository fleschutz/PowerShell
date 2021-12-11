<#
.SYNOPSIS
	Determines the current year 
.DESCRIPTION
	This script determines and speaks the current year by text-to-speech (TTS).
.EXAMPLE
	PS> ./check-year
	✔️ It's 2021.
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

try {
	$Year = (Get-Date).Year
	& "$PSScriptRoot/give-reply.ps1" "It's $Year."
	exit 0 # success
} catch {
	"⚠️ Error: $($Error[0]) ($($MyInvocation.MyCommand.Name):$($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
