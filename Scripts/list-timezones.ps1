#!/snap/bin/powershell
<#
.SYNTAX         ./list-timezones.ps1 
.DESCRIPTION	lists all timezones available
.LINK		https://github.com/fleschutz/PowerShell
.NOTES		Author:	Markus Fleschutz / License: CC0
#>

try {
	get-timezone -listavailable | format-table -property Id,DisplayName,SupportsDaylightSavingTime
	exit 0
} catch {
	write-error "ERROR in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
