<#
.SYNOPSIS
	list-timezones.ps1 
.DESCRIPTION
	Lists all available time zones.
.EXAMPLE
	PS> .\list-timezones.ps1
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

try {
	get-timezone -listavailable | format-table -property Id,DisplayName,SupportsDaylightSavingTime
	exit 0
} catch {
	"⚠️ Error: $($Error[0]) ($($MyInvocation.MyCommand.Name):$($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
