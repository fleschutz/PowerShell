The 'reboot.ps1' Script
========================

This PowerShell script reboots the local computer immediately (needs admin rights).

Parameters
----------
```powershell
PS> ./reboot.ps1 [<CommonParameters>]

[<CommonParameters>]
    This script supports the common parameters: Verbose, Debug, ErrorAction, ErrorVariable, WarningAction, 
    WarningVariable, OutBuffer, PipelineVariable, and OutVariable.
```

Example
-------
```powershell
PS> ./reboot.ps1
⏳ Checking requirements...
...

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
	Reboots the computer (needs admin rights)
.DESCRIPTION
	This PowerShell script reboots the local computer immediately (needs admin rights).
.EXAMPLE
	PS> ./reboot.ps1
	⏳ Checking requirements...
	...
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

#Requires -RunAsAdministrator

try {
	Write-Host "⏳ Checking requirements..."
	& "$PSScriptRoot/check-power.ps1"
	if ($IsLinux -or $IsMacOS) {
		& "$PSScriptRoot/check-drive-space.ps1" /
	} else {
		& "$PSScriptRoot/check-drive-space.ps1" C
	}
	Start-Sleep -seconds 3

	Write-Host "⏳ Rebooting now, please wait..."
	if ($IsLinux) {
		& sudo reboot
	} else {
		Restart-Computer
	}
	exit 0 # success
} catch {
	"⚠️ ERROR: $($Error[0]) (in script line $($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
```

*(page auto-generated from PowerShell script by convert-ps2md.ps1 as of 11/18/2026 14:18:51)*
