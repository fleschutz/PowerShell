<#
.SYNOPSIS
	Lists the details of the current time zone
.DESCRIPTION
	This PowerShell script lists the details of the current time zone.
.EXAMPLE
	PS> ./list-timezone

	Id                         : Europe/Berlin
	DisplayName                : (UTC+01:00) Central European Standard Time
	StandardName               : Central European Standard Time
	DaylightName               : Central European Summer Time
	BaseUtcOffset              : 01:00:00
	SupportsDaylightSavingTime : True
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz / License: CC0
#>

try {
	get-timezone 
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
