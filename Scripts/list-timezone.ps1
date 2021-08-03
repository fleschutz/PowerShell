<#
.SYNOPSIS
	list-timezone.ps1 
.DESCRIPTION
	Lists the details of the current time zone 
.EXAMPLE
	PS> .\list-timezone.ps1
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author:  Markus Fleschutz
	License: CC0
#>

try {
	get-timezone 
	exit 0
} catch {
	write-error "⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
