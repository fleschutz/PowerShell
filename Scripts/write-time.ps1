<#
.SYNOPSIS
	Writes the current time 
.DESCRIPTION
	This PowerShell script queries the current time and writes it to the console.
.EXAMPLE
	PS> ./write-time.ps1
	🕒7:20 PM
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

try {
	[system.threading.thread]::currentThread.currentCulture = [system.globalization.cultureInfo]"en-US"
	$CurrentTime = $((Get-Date).ToShortTimeString())
	"🕒$CurrentTime"
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}