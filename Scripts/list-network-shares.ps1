<#
.SYNTAX       list-network-shares.ps1 
.DESCRIPTION  lists the network shares of the local computer
.LINK         https://github.com/fleschutz/PowerShell
.NOTES        Author: Markus Fleschutz / License: CC0
#>

try {
	get-wmiobject win32_share | where {$_.name -NotLike "*$"}
	exit 0
} catch {
	write-error "⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
