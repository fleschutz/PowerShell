<#
.SYNOPSIS
	Checks the time zone
.DESCRIPTION
	This PowerShell script queries the user's time zone and prints it.
.EXAMPLE
	PS> ./check-time-zone
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

try {
	[system.threading.thread]::currentThread.currentCulture = [system.globalization.cultureInfo]"en-US"
	$Time = $((Get-Date).ToShortTimeString())
	$TZ = (Get-Timezone)
	if ($TZ.SupportsDaylightSavingTime) { $DST=" & +01:00:00 DST" } else { $DST="" }
	Write-Host "✅ $Time in $($TZ.Id) (UTC+$($TZ.BaseUtcOffset)$DST)."
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}