<#
.SYNOPSIS
	Gets the current month name
.DESCRIPTION
	This PowerShell script determines and speaks the current month name by text-to-speech (TTS).
.EXAMPLE
	PS> ./check-month
	✅ It's December.
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

try {
	[system.threading.thread]::currentthread.currentculture=[system.globalization.cultureinfo]"en-US"
	$MonthName = (Get-Date -UFormat %B)
	& "$PSScriptRoot/speak-english.ps1" "It's $MonthName."
	exit 0 # success
} catch {
	"⚠️ ERROR: $($Error[0]) (script line $($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
