<#
.SYNOPSIS
	Say the current time by text-to-speech
.DESCRIPTION
	This script speaks the current time by text-to-speech (TTS).
.EXAMPLE
	PS> ./say-time
	(It's 2:23 PM)
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

try {
	[system.threading.thread]::currentThread.currentCulture=[system.globalization.cultureInfo]"en-US"
	$CurrentTime = $((Get-Date).ToShortTimeString())
	$Answer = "It's $CurrentTime"
	& "$PSScriptRoot/speak-english.ps1" "$Answer"
	write-output "$Answer"
	exit 0 # success
} catch {
	"⚠️ Error: $($Error[0]) ($($MyInvocation.MyCommand.Name):$($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
