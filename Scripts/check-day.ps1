<#
.SYNOPSIS
	Determines the current day 
.DESCRIPTION
	This PowerShell script determines and speaks the current day by text-to-speech (TTS).
.EXAMPLE
	PS> ./check-day
	✔️ It's Sunday.
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz / License: CC0
#>

try {
	[system.threading.thread]::currentthread.currentculture=[system.globalization.cultureinfo]"en-US"
	$Weekday = (Get-Date -format "dddd")
	& "$PSScriptRoot/give-reply.ps1" "It's $Weekday."
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
