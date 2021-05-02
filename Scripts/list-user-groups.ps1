<#
.SYNTAX       list-user-groups.ps1 
.DESCRIPTION  lists the user groups on the local computer
.LINK         https://github.com/fleschutz/PowerShell
.NOTES        Author: Markus Fleschutz / License: CC0
#>

try {
	Get-LocalGroup
	exit 0
} catch {
	write-error "⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
