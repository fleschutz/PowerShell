<#
.SYNOPSIS
	Checks the time until New Year
.DESCRIPTION
	This script checks the time until New Year and replies by text-to-speech (TTS).
.EXAMPLE
	PS> ./check-new-year
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

try {
	$Now = [DateTime]::Now
	$Diff = [Datetime]("12/31/" + $Now.Year) – $Now

	$Reply = "New Year is in $($Diff.Days) days."
	"✔️ $Reply"
	& "$PSScriptRoot/speak-english.ps1" "$Reply"
	exit 0 # success
} catch {
	"⚠️ Error: $($Error[0]) ($($MyInvocation.MyCommand.Name):$($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
