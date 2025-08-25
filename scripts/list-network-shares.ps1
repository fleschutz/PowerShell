<#
.SYNOPSIS
	Lists the network shares
.DESCRIPTION
	This PowerShell script lists all network shares (aka "shared folders") of the local computer.
.EXAMPLE
	PS> ./list-network-shares.ps1
	✅ Shared folder \\LAPTOP\Public -> D:\Public ("File transfer folder")
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

try {
	if ($IsLinux -or $IsMacOS) {
		# TODO
	} else {
		$shares = Get-WmiObject win32_share | where {$_.name -NotLike "*$"} 
		foreach ($share in $shares) {
			if ($share.Description -eq "") {
				Write-Host "✅ Shared folder \\$(hostname)\$($share.Name) -> $($share.Path)"
			} else {
				Write-Host "✅ Shared folder \\$(hostname)\$($share.Name) -> $($share.Path) (`"$($share.Description)`")"
			}
		}
	}
	exit 0 # success
} catch {
	"⚠️ ERROR: $($Error[0]) (script line $($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
