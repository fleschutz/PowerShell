<#
.SYNOPSIS
	Determines the current time 
.DESCRIPTION
	This script determines and speaks the current time by text-to-speech (TTS).
.EXAMPLE
	PS> ./check-time
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

try {
	[system.threading.thread]::currentThread.currentCulture=[system.globalization.cultureInfo]"en-US"
	$CurrentTime = $((Get-Date).ToShortTimeString())

	& "$PSScriptRoot/give-reply.ps1" "It's $CurrentTime"
	exit 0 # success
} catch {
	"⚠️ Error: $($Error[0]) ($($MyInvocation.MyCommand.Name):$($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
