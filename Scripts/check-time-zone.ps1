<#
.SYNOPSIS
	Checks the time zone setting
.DESCRIPTION
	This PowerShell script determines and prints the current time zone.
.EXAMPLE
	PS> ./check-time-zone
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

try {
	$TimeZone = (Get-Timezone)

	"✅ Time zone is $($TimeZone.DisplayName)."
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}