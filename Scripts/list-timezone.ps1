<#
.SYNOPSIS
	Lists the details of the current time zone
.DESCRIPTION
	This script lists the details of the current time zone.
.EXAMPLE
	PS> ./list-timezone

	Id                         : Europe/Berlin
	DisplayName                : (UTC+01:00) Central European Standard Time
	StandardName               : Central European Standard Time
	DaylightName               : Central European Summer Time
	BaseUtcOffset              : 01:00:00
	SupportsDaylightSavingTime : True
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

try {
	get-timezone 
	exit 0 # success
} catch {
	"⚠️ Error: $($Error[0]) ($($MyInvocation.MyCommand.Name):$($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
