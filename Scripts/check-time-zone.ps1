<#
.SYNOPSIS
	Determines the time zone
.DESCRIPTION
	This PowerShell script determines and returns the current time zone.
.EXAMPLE
	PS> ./check-time-zone
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz / License: CC0
#>

try {
	$TimeZone = (Get-Timezone)

	& "$PSScriptRoot/give-reply.ps1" "It's $($TimeZone.DisplayName)"
	exit 0 # success
} catch {
	"⚠️ Error: $($Error[0]) ($($MyInvocation.MyCommand.Name):$($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
