<#
.SYNOPSIS
	Checks the time until Independence Day
.DESCRIPTION
	This script checks the time until Indepence Day and replies by text-to-speech (TTS).
.EXAMPLE
	PS> ./check-independence-day
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

try {
	$Now = [DateTime]::Now
	$IndependenceDay = [Datetime]("07/04/" + $Now.Year)
	if ($Now -lt $IndependenceDay) {
		$Diff = $IndependenceDay – $Now
		& "$PSScriptRoot/give-reply.ps1" "Independence Day on July 4th is in $($Diff.Days) days."
	} else {
		$Diff = $Now - $IndependenceDay
		& "$PSScriptRoot/give-reply.ps1" "Independence Day on July 4th was $($Diff.Days) days ago."
	}
	exit 0 # success
} catch {
	"⚠️ Error: $($Error[0]) ($($MyInvocation.MyCommand.Name):$($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
