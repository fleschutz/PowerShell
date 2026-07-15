<#
.SYNOPSIS
	Speaks the current time 
.DESCRIPTION
	This PowerShell script speaks the current time.
.EXAMPLE
	PS> ./speak-time.ps1
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

try {
	[system.threading.thread]::currentThread.currentCulture = [system.globalization.cultureInfo]"en-US"
	$CurrentTime = $((Get-Date).ToShortTimeString())
	& "$PSScriptRoot/speak-english.ps1" "It's $CurrentTime."
	exit 0 # success
} catch {
	"⚠️ ERROR: $($Error[0]) (script line $($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
