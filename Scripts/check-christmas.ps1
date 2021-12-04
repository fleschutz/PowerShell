<#
.SYNOPSIS
	Checks the time until Christmas
.DESCRIPTION
	This script checks the time until Christmas and replies by text-to-speech (TTS).
.EXAMPLE
	PS> ./check-christmas
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

try {
	$Now = [DateTime]::Now
	$Diff = [Datetime]("12/25/" + $Now.Year) – $Now

	$Reply = "$($Diff.Days) days until Christmas."
	"✔️ $Reply"
	& "$PSScriptRoot/speak-english.ps1" "$Reply"
	exit 0 # success
} catch {
	"⚠️ Error: $($Error[0]) ($($MyInvocation.MyCommand.Name):$($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
