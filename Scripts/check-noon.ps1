<#
.SYNOPSIS
	Checks the time until Noon
.DESCRIPTION
	This script checks the time until Noon and replies by text-to-speech (TTS).
.EXAMPLE
	PS> ./check-noon
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

try {
	$Now = [DateTime]::Now
	$Noon = Get-Date -Hour 12 -Minute 0 -Second 0
	if ($Now -lt $Noon) {
		$Delta = $Noon - $Now
		$Reply = "Noon is in $($Delta.Hours) hours, $($Delta.Minutes) minutes."
	} else {
		$Delta = $Now - $Noon
		$Reply = "Noon was $($Delta.Hours) hours, $($Delta.Minutes) minutes ago."
	}
	& "$PSScriptRoot/give-reply.ps1" "$Reply"
	exit 0 # success
} catch {
	"⚠️ Error: $($Error[0]) ($($MyInvocation.MyCommand.Name):$($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
