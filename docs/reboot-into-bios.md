The 'reboot-into-bios.ps1' Script
========================

This PowerShell script reboots the local computer immediately into the BIOS (needs admin rights).

Parameters
----------
```powershell
PS> ./reboot-into-bios.ps1 [<CommonParameters>]

[<CommonParameters>]
    This script supports the common parameters: Verbose, Debug, ErrorAction, ErrorVariable, WarningAction, 
    WarningVariable, OutBuffer, PipelineVariable, and OutVariable.
```

Example
-------
```powershell
PS> ./reboot-into-bios.ps1
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
	Reboots into BIOS (needs admin rights)
.DESCRIPTION
	This PowerShell script reboots the local computer immediately into the BIOS (needs admin rights).
.EXAMPLE
	PS> ./reboot-into-bios.ps1
	⏳ Checking requirements...
	...
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

#Requires -RunAsAdministrator

# Requires admin privileges to run
if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
	Write-Host "This script requires administrative privileges." -ForegroundColor Red
	Write-Host "Please run PowerShell as Administrator and try again." -ForegroundColor Yellow
	pause
	exit 1
}

try {
	Write-Host "⏳ Checking requirements..."
	& "$PSScriptRoot/check-power.ps1"
	if ($IsLinux -or $IsMacOS) {
		& "$PSScriptRoot/check-drive-space.ps1" /
	} else {
		& "$PSScriptRoot/check-drive-space.ps1" C
	}
	# Get boot configuration
	$bootConfig = bcdedit /enum firmware
	if ($lastExitCode -ne 0) { throw "Failed to get boot configuration" }

	Start-Sleep -seconds 3

	Write-Host "⏳ Rebooting into BIOS/UEFI..."
	# Set the one-time boot to UEFI
	$result = shutdown /r /fw /t 0
	if ($lastExitCode -ne 0) { throw "Failed to initiate reboot" }

	exit 0 # success
} catch {
	"⚠️ ERROR: $($Error[0]) (in script line $($_.InvocationInfo.ScriptLineNumber))"
	pause
	exit 1
}
```

*(page generated from script by convert-ps2md.ps1 as of 11/16/2026 17:46:07)*
