<#
.SYNOPSIS
	Lists the network shares
.DESCRIPTION
	This PowerShell script lists all network shares (aka "shared folders") of the local computer.
.EXAMPLE
	PS> ./list-network-shares.ps1
	✅ Shared folder \\LAPTOP\Public -> D:\Public ("Public folder for file transfer")
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

try {
	if ($IsLinux) {
		# TODO
	} else {
		$shares = Get-WmiObject win32_share | where {$_.name -NotLike "*$"} 
		foreach ($share in $shares) {
			Write-Output "✅ Shared folder \\$(hostname)\$($share.Name) -> $($share.Path) (`"$($share.Description)`")"
		}
	}
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
