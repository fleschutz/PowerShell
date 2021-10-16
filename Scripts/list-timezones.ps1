<#
.SYNOPSIS
	Lists all available time zones
.DESCRIPTION
	This script lists all available time zones.
.EXAMPLE
	PS> ./list-timezones

	Id                              DisplayName                            SupportsDaylight
                                                                               SavingTime
	--                              -----------                            ----------------
	Hawaiian Standard Time          (UTC-10:00) Hawaii                     False
	Alaskan Standard Time           (UTC-09:00) Alaska                     True
	...
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

try {
	get-timezone -listavailable | format-table -property Id,DisplayName,SupportsDaylightSavingTime
	exit 0 # success
} catch {
	"⚠️ Error: $($Error[0]) ($($MyInvocation.MyCommand.Name):$($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
