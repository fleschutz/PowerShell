<#
.SYNOPSIS
	Checks the time until Independence Day
.DESCRIPTION
	This PowerShell script checks the time until Indepence Day and replies by text-to-speech (TTS).
.EXAMPLE
	PS> ./check-independence-day.ps1
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

try {
	$Now = [DateTime]::Now
	$IndependenceDay = [Datetime]("07/04/" + $Now.Year)
	if ($Now -lt $IndependenceDay) {
		$Diff = $IndependenceDay – $Now
		& "$PSScriptRoot/speak-english.ps1" "Independence Day on July 4th is in $($Diff.Days) days."
	} else {
		$Diff = $Now - $IndependenceDay
		& "$PSScriptRoot/speak-english.ps1" "Independence Day on July 4th was $($Diff.Days) days ago."
	}
	exit 0 # success
} catch {
	"⚠️ ERROR: $($Error[0]) (script line $($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
