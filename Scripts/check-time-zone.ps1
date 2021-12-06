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

	& "$PSScriptRoot/give-reply.ps1" "It's $($TimeZone.DisplayName)"
	exit 0 # success
} catch {
	"⚠️ Error: $($Error[0]) ($($MyInvocation.MyCommand.Name):$($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
