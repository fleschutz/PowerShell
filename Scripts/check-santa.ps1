<#
.SYNOPSIS
	Checks the time until Saint Nicholas Day
.DESCRIPTION
	This script checks the time until Saint Nicholas Day and replies by text-to-speech (TTS).
.EXAMPLE
	PS> ./check-santa
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

try {
	$Now = [DateTime]::Now
	$Diff = [Datetime]("12/06/" + $Now.Year) – $Now

	& "$PSScriptRoot/give-reply.ps1" "Saint Nicholas Day is in $($Diff.Days) days."
	exit 0 # success
} catch {
	"⚠️ Error: $($Error[0]) ($($MyInvocation.MyCommand.Name):$($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
