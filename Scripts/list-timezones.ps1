<#
.SYNOPSIS
	list-timezones.ps1 
.DESCRIPTION
	Lists all available time zones 
.EXAMPLE
	PS> .\list-timezones.ps1
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author:  Markus Fleschutz
	License: CC0
#>

try {
	get-timezone -listavailable | format-table -property Id,DisplayName,SupportsDaylightSavingTime
	exit 0
} catch {
	write-error "⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
