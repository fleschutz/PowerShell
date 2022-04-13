<#
.SYNOPSIS
	Lists all network shares of the local computer
.DESCRIPTION
	This PowerShell script lists all network shares of the local computer.
.EXAMPLE
	PS> ./list-network-shares

	Name  Path     Description
	----  ----     -----------
	Users C:\Users
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz / License: CC0
#>

try {
	get-wmiobject win32_share | where {$_.name -NotLike "*$"}
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
