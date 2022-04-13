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
	Alaskan Standard Time           (UTC-09:00) Alaska                     True
	...
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz / License: CC0
#>

try {
	get-timezone -listavailable | format-table -property Id,DisplayName,SupportsDaylightSavingTime
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
