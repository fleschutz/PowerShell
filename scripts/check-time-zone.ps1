<#
.SYNOPSIS
	Checks the time zone
.DESCRIPTION
	This PowerShell script queries the local time zone and prints it.
.EXAMPLE
	PS> ./check-time-zone.ps1
	✅ 3:27 PM West Europe Summer Time (UTC+01:00:00 +1h DST)
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

try {
	[system.threading.thread]::currentThread.currentCulture = [system.globalization.cultureInfo]"en-US"
	$Time = $((Get-Date).ToShortTimeString())
	$TZ = (Get-Timezone)
	$offset = $TZ.BaseUtcOffset
	if ($TZ.SupportsDaylightSavingTime) {
		$TZName = $TZ.DaylightName
		$DST=" +1h DST"
	} else {
		$TZName = $TZ.StandardName
		$DST=""
	}
	Write-Host "✅ $Time $TZName (UTC+$($offset)$($DST))"
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
