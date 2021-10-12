<#
.SYNOPSIS
	Say the current date by text-to-speech
.DESCRIPTION
	This script speaks the current date by text-to-speech (TTS).
.EXAMPLE
	PS> ./say-date
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

try {
	[system.threading.thread]::currentthread.currentculture=[system.globalization.cultureinfo]"en-US"
	& "$PSScriptRoot/speak-english.ps1" "Today is $((Get-Date).ToShortDateString())"
	exit 0 # success
} catch {
	"⚠️ Error: $($Error[0]) ($($MyInvocation.MyCommand.Name):$($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
