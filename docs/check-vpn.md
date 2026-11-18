The 'check-vpn.ps1' Script
========================

This PowerShell script queries the status of the computer's VPNs and prints it.

Parameters
----------
```powershell
PS> ./check-vpn.ps1 [<CommonParameters>]

[<CommonParameters>]
    This script supports the common parameters: Verbose, Debug, ErrorAction, ErrorVariable, WarningAction, 
    WarningVariable, OutBuffer, PipelineVariable, and OutVariable.
```

Example
-------
```powershell
PS> ./check-vpn.ps1
✅ Internet VPN to NASA L2TP is connected

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
	Checks the VPN status
.DESCRIPTION
	This PowerShell script queries the status of the computer's VPNs and prints it.
.EXAMPLE
	PS> ./check-vpn.ps1
	✅ Internet VPN to NASA L2TP is connected
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

try {
	$noVPN = $true
	if ($IsLinux) {
		# TODO
	} else {
		$VPNs = Get-VPNConnection
		foreach($VPN in $VPNs) {
			Write-Output "✅ Internet VPN to $($VPN.Name) is $($VPN.ConnectionStatus.ToLower())"
			$noVPN = $false
		}
	}
	if ($noVPN) { Write-Output "⚠️ No VPN configured" }
	exit 0 # success
} catch {
	Write-Output "⚠️ ERROR: $($Error[0]) (at line $($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
```

*(page auto-generated from PowerShell script by convert-ps2md.ps1 as of 11/18/2026 14:18:44)*
