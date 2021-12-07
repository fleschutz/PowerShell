<#
.SYNOPSIS
	Checks the time until Midnight
.DESCRIPTION
	This script checks the time until Midnight and replies by text-to-speech (TTS).
.EXAMPLE
	PS> ./check-midnight
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

try {
	$Now = [DateTime]::Now
	if ($Now.Hour -lt 12) {
		$Midnight = Get-Date -Hour 0 -Minute 0 -Second 0
		$Delta = $Now - $Midnight
		$Reply = "Midnight was $($Delta.Hours) hours, $($Delta.Minutes) minutes ago."
	} else {
		$Midnight = Get-Date -Hour 23 -Minute 59 -Second 59
		$Delta = $Midnight - $Now
		$Reply = "Midnight is in $($Delta.Hours) hours, $($Delta.Minutes) minutes."
	}
	& "$PSScriptRoot/give-reply.ps1" "$Reply"
	exit 0 # success
} catch {
	"⚠️ Error: $($Error[0]) ($($MyInvocation.MyCommand.Name):$($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
