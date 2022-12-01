<#
.SYNOPSIS
	Query PowerShell details
.DESCRIPTION
	This PowerShell script queries and lists details of PowerShell.
.EXAMPLE
	PS> ./check-powershell
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

try {
	$Version = $PSVersionTable.PSVersion
	$Edition = $PSVersionTable.PSEdition
	"✅ PowerShell $Version ($Edition edition)"
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}