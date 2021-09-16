<#
.SYNOPSIS
	list-user-groups.ps1 
.DESCRIPTION
	Lists the user groups on the local computer.
.EXAMPLE
	PS> .\list-user-groups.ps1
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

try {
	Get-LocalGroup
	exit 0
} catch {
	"⚠️ Error: $($Error[0]) ($($MyInvocation.MyCommand.Name):$($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
