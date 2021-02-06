#!/snap/bin/powershell
<#
.SYNTAX         ./list-user-groups.ps1 
.DESCRIPTION	lists all user groups
.LINK		https://github.com/fleschutz/PowerShell
.NOTES		Author:	Markus Fleschutz / License: CC0
#>

try {
	Get-LocalGroup
	Get-LocalGroupMember -name users
	exit 0
} catch {
	write-error "ERROR in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
