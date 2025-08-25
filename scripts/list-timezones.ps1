<#
.SYNOPSIS
	Lists all available time zones
.DESCRIPTION
	This PowerShell script lists all available time zones.
.EXAMPLE
	PS> ./list-timezones

	Id                              DisplayName                            SupportsDaylight
                                                                               SavingTime
	--                              -----------                            ----------------
	Hawaiian Standard Time          (UTC-10:00) Hawaii                     False
	...
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

try {
	Get-Timezone -listavailable | Format-Table -property Id,DisplayName,SupportsDaylightSavingTime
	exit 0 # success
} catch {
	"⚠️ ERROR: $($Error[0]) (script line $($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
