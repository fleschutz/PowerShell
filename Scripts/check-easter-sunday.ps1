<#
.SYNOPSIS
	Checks the time until Easter Sunday
.DESCRIPTION
	This script checks the time until Easter Sunday and replies by text-to-speech (TTS).
.EXAMPLE
	PS> ./check-easter-sunday
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

try {
	$Now = [DateTime]::Now
	$Easter = [Datetime]("04/17/2022")
	if ($Now -lt $Easter) {
		$Diff = $Easter – $Now
		& "$PSScriptRoot/give-reply.ps1" "Easter Sunday on April 17 is in $($Diff.Days) days."
	} else {
		$Diff = $Now - $Easter
		& "$PSScriptRoot/give-reply.ps1" "Easter Sunday on April 17 was $($Diff.Days) days ago."
	}
	exit 0 # success
} catch {
	"⚠️ Error: $($Error[0]) ($($MyInvocation.MyCommand.Name):$($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
