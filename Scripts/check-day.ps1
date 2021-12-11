<#
.SYNOPSIS
	Determines the current day 
.DESCRIPTION
	This script determines and speaks the current day by text-to-speech (TTS).
.EXAMPLE
	PS> ./check-day
	✔️ It's Sunday.
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

try {
	[system.threading.thread]::currentthread.currentculture=[system.globalization.cultureinfo]"en-US"
	$Weekday = (Get-Date -format "dddd")
	& "$PSScriptRoot/give-reply.ps1" "It's $Weekday."
	exit 0 # success
} catch {
	"⚠️ Error: $($Error[0]) ($($MyInvocation.MyCommand.Name):$($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
