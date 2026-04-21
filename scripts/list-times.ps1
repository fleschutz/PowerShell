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

function TimeAs([string]$timeZone) {
	[system.threading.thread]::currentThread.currentCulture = [system.globalization.cultureInfo]"de-de"
	$localTime = [System.TimeZoneInfo]::ConvertTimeBySystemTimeZoneId((Get-Date), $timeZone)
	return $localTime.ToShortTimeString()
}

try {
	Write-Host " ----------------------------------------------------------------------------- "
	Write-Host "|  Hawaii     LA  Denver    NYC London  Paris  Dubai  Beijing  Tokyo  Sydney  |" -foregroundColor green
	Write-Host "| 🕒$(TimeAs "Hawaiian Standard Time")  $(TimeAs "Pacific Standard Time")   $(TimeAs "Mountain Standard Time")  $(TimeAs "Eastern Standard Time")  $(TimeAs "GMT Standard Time")  $(TimeAs "Central Europe Standard Time")  $(TimeAs "Arab Standard Time")    $(TimeAs "China Standard Time")  $(TimeAs "Tokyo Standard Time")   $(TimeAs "AUS Eastern Standard Time")  |"
	Write-Host " ----------------------------------------------------------------------------- "
	exit 0 # success
} catch {
	"⚠️ ERROR: $($Error[0]) (at line $($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
