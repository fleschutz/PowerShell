<#
.SYNOPSIS
	Say the current date by text-to-speech
.DESCRIPTION
	This script speaks the current date by text-to-speech (TTS).
.EXAMPLE
	PS> ./say-date
	(It's Sunday, October 17, 2021)
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

try {
	[system.threading.thread]::currentthread.currentculture=[system.globalization.cultureinfo]"en-US"
	$Weekday = (Get-Date -format "dddd")
	$CurrentDate = (Get-Date).ToShortDateString()
	& "$PSScriptRoot/speak-english.ps1" "It's $Weekday, $CurrentDate"
	exit 0 # success
} catch {
	"⚠️ Error: $($Error[0]) ($($MyInvocation.MyCommand.Name):$($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
