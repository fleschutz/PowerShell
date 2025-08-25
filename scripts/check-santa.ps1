<#
.SYNOPSIS
	Checks the time until Saint Nicholas Day
.DESCRIPTION
	This PowerShell script checks the time until Saint Nicholas Day and replies by text-to-speech (TTS).
.EXAMPLE
	PS> ./check-santa
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

try {
	$Now = [DateTime]::Now
	$Diff = [Datetime]("12/06/" + $Now.Year) – $Now

	& "$PSScriptRoot/speak-english.ps1" "Saint Nicholas Day is in $($Diff.Days) days."
	exit 0 # success
} catch {
	"⚠️ ERROR: $($Error[0]) (script line $($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
