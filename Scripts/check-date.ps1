<#
.SYNOPSIS
	Determines the current date 
.DESCRIPTION
	This script determines and speaks the current date by text-to-speech (TTS).
.EXAMPLE
	PS> ./check-date
	✔️ It's Sunday, October 17, 2021
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

try {
	[system.threading.thread]::currentthread.currentculture=[system.globalization.cultureinfo]"en-US"
	$Weekday = (Get-Date -format "dddd")
	$CurrentDate = (Get-Date).ToShortDateString()
	$Reply = "It's $Weekday, $CurrentDate"
	"✔️ $Reply"
	& "$PSScriptRoot/speak-english.ps1" "$Reply"
	exit 0 # success
} catch {
	"⚠️ Error: $($Error[0]) ($($MyInvocation.MyCommand.Name):$($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
