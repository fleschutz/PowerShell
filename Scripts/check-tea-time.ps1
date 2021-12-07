<#
.SYNOPSIS
	Checks the time until Tea time
.DESCRIPTION
	This script checks the time until Tea time and replies by text-to-speech (TTS).
.EXAMPLE
	PS> ./check-tea-time
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

try {
	$Now = [DateTime]::Now
	$TeaTime = Get-Date -Hour 16 -Minute 0 -Second 0
	if ($Now -lt $TeaTime) {
		$Delta = $TeaTime - $Now
		$Reply = "Tea time is in $($Delta.Hours) hours, $($Delta.Minutes) minutes."
	} else {
		$Delta = $Now - $TeaTime
		$Reply = "Tea time was $($Delta.Hours) hours, $($Delta.Minutes) minutes ago."
	}
	& "$PSScriptRoot/give-reply.ps1" "$Reply"
	exit 0 # success
} catch {
	"⚠️ Error: $($Error[0]) ($($MyInvocation.MyCommand.Name):$($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
