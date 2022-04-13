<#
.SYNOPSIS
	Determines the current time 
.DESCRIPTION
	This PowerShell script determines and speaks the current time by text-to-speech (TTS).
.EXAMPLE
	PS> ./check-time
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz / License: CC0
#>

try {
	[system.threading.thread]::currentThread.currentCulture=[system.globalization.cultureInfo]"en-US"
	$CurrentTime = $((Get-Date).ToShortTimeString())

	& "$PSScriptRoot/give-reply.ps1" "It's $CurrentTime"
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
