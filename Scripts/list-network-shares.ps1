<#
.SYNOPSIS
	list-network-shares.ps1 
.DESCRIPTION
	Lists the network shares of the local computer
.EXAMPLE
	PS> ./list-network-shares
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

try {
	get-wmiobject win32_share | where {$_.name -NotLike "*$"}
	exit 0
} catch {
	"⚠️ Error: $($Error[0]) ($($MyInvocation.MyCommand.Name):$($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
