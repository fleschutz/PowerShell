<#
.SYNOPSIS
	Lists time zone details
.DESCRIPTION
	This PowerShell script lists the details of the current time zone.
.EXAMPLE
	PS> ./list-timezone

	Id                         : Europe/Berlin
	DisplayName                : (UTC+01:00) Central European Standard Time
	...
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

try {
	[system.threading.thread]::currentThread.currentCulture = [system.globalization.cultureInfo]"en-US"
	Get-Timezone 
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
