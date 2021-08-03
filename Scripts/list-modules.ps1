<#
.SYNOPSIS
	list-modules.ps1 
.DESCRIPTION
	Lists all PowerShell modules
.EXAMPLE
	PS> .\list-modules.ps1
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author:  Markus Fleschutz
	License: CC0
#>

try {
	get-module | format-table
	exit 0
} catch {
	write-error "⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
