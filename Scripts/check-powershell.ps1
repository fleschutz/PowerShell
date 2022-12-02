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
	$Modules = Get-Module
	$Aliases = Get-Alias
	"✅ PowerShell $Version ($Edition edition) with $($Modules.Count) modules and $($Aliases.Count) aliases"
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}