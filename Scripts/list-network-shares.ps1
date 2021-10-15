<#
.SYNOPSIS
	Lists all network shares of the local computer
.DESCRIPTION
	This script lists all network shares of the local computer.
.EXAMPLE
	PS> ./list-network-shares

	Name  Path     Description
	----  ----     -----------
	Users C:\Users
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

try {
	get-wmiobject win32_share | where {$_.name -NotLike "*$"}
	exit 0 # success
} catch {
	"⚠️ Error: $($Error[0]) ($($MyInvocation.MyCommand.Name):$($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
