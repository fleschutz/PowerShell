The 'check-firewall.ps1' Script
========================

This PowerShell script queries the status of the firewall and prints it to the console.

Parameters
----------
```powershell
PS> ./check-firewall.ps1 [<CommonParameters>]

[<CommonParameters>]
    This script supports the common parameters: Verbose, Debug, ErrorAction, ErrorVariable, WarningAction, 
    WarningVariable, OutBuffer, PipelineVariable, and OutVariable.
```

Example
-------
```powershell
PS> ./check-firewall.ps1
✅ Local firewall is on

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
	Checks the firewall status
.DESCRIPTION
	This PowerShell script queries the status of the firewall and prints it to the console.
.EXAMPLE
	PS> ./check-firewall.ps1
	✅ Local firewall is on
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

try {
	if ($IsLinux) {
		Write-Host "✅ Firewall " -noNewline
		& sudo ufw status
	} else {
		$enabled = (Get-ItemProperty 'HKLM:\SYSTEM\ControlSet001\Services\SharedAccess\Parameters\FirewallPolicy\DomainProfile').EnableFirewall
		if ($enabled) {
			Write-Host "✅ Local firewall enabled"
		} else {
			Write-Host "⚠️ Local firewall disabled!"
		}
	}
	exit 0 # success
} catch {
	"⚠️ ERROR: $($Error[0]) (at line $($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
```

*(page generated from script by convert-ps2md.ps1 as of 11/16/2026 17:45:59)*
