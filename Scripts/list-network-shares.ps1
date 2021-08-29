<#
.SYNOPSIS
	list-network-shares.ps1 
.DESCRIPTION
	Lists the network shares of the local computer.
.EXAMPLE
	PS> .\list-network-shares.ps1
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

try {
	get-wmiobject win32_share | where {$_.name -NotLike "*$"}
	exit 0
} catch {
	write-error "⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
