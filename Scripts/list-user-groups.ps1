<#
.SYNOPSIS
	list-user-groups.ps1 
.DESCRIPTION
	Lists the user groups on the local computer
.EXAMPLE
	PS> .\list-user-groups.ps1
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz / License: CC0
#>

try {
	Get-LocalGroup
	exit 0
} catch {
	write-error "⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
