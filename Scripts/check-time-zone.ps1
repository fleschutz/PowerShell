<#
.SYNOPSIS
	Checks the time zone
.DESCRIPTION
	This PowerShell script queries the time zone and prints it.
.EXAMPLE
	PS> ./check-time-zone
	✅ 11:13 AM (UTC + 01:00:00 W. Europe Standard Time + 01:00:00 daylight saving time)
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

try {
	[system.threading.thread]::currentThread.currentCulture = [system.globalization.cultureInfo]"en-US"
	$Time = $((Get-Date).ToShortTimeString())
	$TZ = (Get-Timezone)
	if ($TZ.SupportsDaylightSavingTime) { $DST="+ 01:00:00 daylight saving time" } else { $DST="" }
	Write-Host "✅ $Time (UTC + $($TZ.BaseUtcOffset) $($TZ.Id) $DST)"
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}