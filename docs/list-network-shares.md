The 'list-network-shares.ps1' Script
========================

This PowerShell script lists all network shares (aka "shared folders") on the local computer.

Parameters
----------
```powershell
PS> ./list-network-shares.ps1 [<CommonParameters>]

[<CommonParameters>]
    This script supports the common parameters: Verbose, Debug, ErrorAction, ErrorVariable, WarningAction, 
    WarningVariable, OutBuffer, PipelineVariable, and OutVariable.
```

Example
-------
```powershell
PS> ./list-network-shares.ps1
✅ Network share \\LAPTOP\Public -> D:\Public\ ('File transfer folder')

```

Notes
-----
Author: Markus Fleschutz | License: CC0

Related Links
-------------
https://github.com/fleschutz/PowerShell

Script Content
--------------
```powershell
<#
.SYNOPSIS
	List all network shares
.DESCRIPTION
	This PowerShell script lists all network shares (aka "shared folders") on the local computer.
.EXAMPLE
	PS> ./list-network-shares.ps1
	✅ Network share \\LAPTOP\Public -> D:\Public\ ('File transfer folder')
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
				Write-Output "✅ Network share \\$(hostname)\$($share.Name) -> $($share.Path)\"
			} else {
				Write-Output "✅ Network share \\$(hostname)\$($share.Name) -> $($share.Path)\ ('$($share.Description)')"
			}
		}
	}
	exit 0 # success
} catch {
	Write-Output "⚠️ ERROR: $($Error[0]) (in script line $($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
```

*(page auto-generated from PowerShell script by convert-ps2md.ps1 as of 11/18/2026 14:18:48)*
