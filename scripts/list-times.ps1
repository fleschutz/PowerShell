<#
.SYNOPSIS
	Lists the times world-wide
.DESCRIPTION
	This PowerShell script lists the current time in big cities world-wide.
.EXAMPLE
	PS> ./list-times.ps1
	🕒03:11 in Hawaii
	🕒06:11 in Los Angeles
	🕒09:11 in New York
	...
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

function WriteTimeIn([string]$location, [string]$timeZone) {
	[system.threading.thread]::currentThread.currentCulture = [system.globalization.cultureInfo]"de-de"
	$localTime = [System.TimeZoneInfo]::ConvertTimeBySystemTimeZoneId((Get-Date), $timeZone)
	$timeAsString = $($localTime.ToShortTimeString())
	"🕒$timeAsString in $location"
}

try {
	WriteTimeIn "Hawaii"      "Hawaiian Standard Time"
	WriteTimeIn "Los Angeles" "Pacific Standard Time"
	WriteTimeIn "New York"    "Eastern Standard Time"
	WriteTimeIn "London"      "Greenwich Standard Time"
	WriteTimeIn "Paris"       "Central Europe Standard Time"
	WriteTimeIn "Dubai"       "Arab Standard Time"
	WriteTimeIn "Singapore"   "Singapore Standard Time"
	WriteTimeIn "Tokyo"       "Tokyo Standard Time"
	WriteTimeIn "Sydney"      "AUS Eastern Standard Time"
	exit 0 # success
} catch {
	"⚠️ ERROR: $($Error[0]) (at line $($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
