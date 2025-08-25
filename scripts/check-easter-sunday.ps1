<#
.SYNOPSIS
	Checks the time until Easter Sunday
.DESCRIPTION
	This PowerShell script checks the time until Easter Sunday and replies by text-to-speech (TTS).
.EXAMPLE
	PS> ./check-easter-sunday
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

try {
	$Now = [DateTime]::Now
	$Easter = [Datetime]("04/17/2022")
	if ($Now -lt $Easter) {
		$Diff = $Easter – $Now
		& "$PSScriptRoot/speak-english.ps1" "Easter Sunday on April 17 is in $($Diff.Days) days."
	} else {
		$Diff = $Now - $Easter
		& "$PSScriptRoot/speak-english.ps1" "Easter Sunday on April 17 was $($Diff.Days) days ago."
	}
	exit 0 # success
} catch {
	"⚠️ ERROR: $($Error[0]) (script line $($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
