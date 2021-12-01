<#
.SYNOPSIS
	Determines the time zone
.DESCRIPTION
	This script determines and returns the current time zone.
.EXAMPLE
	PS> ./check-time-zone
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

try {
	$TimeZone = (Get-Timezone)
	$Reply = "It's $($TimeZone.DisplayName)"
	"✔️ $Reply"
	& "$PSScriptRoot/speak-english.ps1" "$Reply"
	exit 0 # success
} catch {
	"⚠️ Error: $($Error[0]) ($($MyInvocation.MyCommand.Name):$($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
