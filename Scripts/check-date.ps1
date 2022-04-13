<#
.SYNOPSIS
	Determines the current date 
.DESCRIPTION
	This PowerShell script determines and speaks the current date by text-to-speech (TTS).
.EXAMPLE
	PS> ./check-date
	✔️ It's Sunday, October 17, 2021
.NOTES
	Author: Markus Fleschutz / License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

try {
	[system.threading.thread]::currentthread.currentculture=[system.globalization.cultureinfo]"en-US"
	$Weekday = (Get-Date -format "dddd")
	$CurrentDate = (Get-Date).ToShortDateString()

	& "$PSScriptRoot/give-reply.ps1" "It's $Weekday, $CurrentDate"
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
