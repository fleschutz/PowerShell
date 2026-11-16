The 'install-updates.ps1' Script
========================

This PowerShell script installs software updates for the local machine (might need admin rights).
HINT: Use the script 'list-updates.ps1' to list the latest software updates in advance.

Parameters
----------
```powershell
PS> ./install-updates.ps1 [<CommonParameters>]

[<CommonParameters>]
    This script supports the common parameters: Verbose, Debug, ErrorAction, ErrorVariable, WarningAction, 
    WarningVariable, OutBuffer, PipelineVariable, and OutVariable.
```

Example
-------
```powershell
PS> ./install-updates.ps1
⏳ (1/2) Checking requirements...
✅ Drive C: uses 56% of 1TB: 441GB free
✅ Swap space uses 22% of 4GB: 3GB free



⏳ (2/2) Querying Microsoft Store...
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
	Installs software updates
.DESCRIPTION
	This PowerShell script installs software updates for the local machine (might need admin rights).
	HINT: Use the script 'list-updates.ps1' to list the latest software updates in advance.
.EXAMPLE
	PS> ./install-updates.ps1
	⏳ (1/2) Checking requirements...
	✅ Drive C: uses 56% of 1TB: 441GB free
	✅ Swap space uses 22% of 4GB: 3GB free

	⏳ (2/2) Querying Microsoft Store...
	...
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

#requires -version 5.1

try {
	$stopWatch = [system.diagnostics.stopwatch]::startNew()

	Write-Host "`n⏳ Checking requirements..." -foregroundColor blue
	& "$PSScriptRoot/check-power.ps1"
	& "$PSScriptRoot/check-smart-devices.ps1"
	if ($IsLinux -or $IsMacOS) {
		& "$PSScriptRoot/check-drive-space.ps1" /
	} else {
		& "$PSScriptRoot/check-drive-space.ps1" C
	}
	& "$PSScriptRoot/check-swap-space.ps1"
	Start-Sleep -seconds 3

	if (Get-Command apt -ErrorAction SilentlyContinue) {
		Write-Host "`n⏳ Querying APT package updates..." -foregroundColor blue
		& sudo apt update

		Write-Host "`n⏳ Removing obsolete packages to save space..." -foregroundColor blue
		& sudo apt autoremove --yes

		Write-Host "`n⏳ Upgrading installed packages..." -foregroundColor blue
		& sudo apt upgrade --yes
	}
	if (Get-Command snap -ErrorAction SilentlyContinue) {
		Write-Host "`n⏳ Upgrading installed Snaps..." -foregroundColor blue
		& sudo snap refresh
	}
	if (Get-Command softwareupdate -ErrorAction SilentlyContinue) {
		Write-Host "`n⏳ Updating software..." -foregroundColor blue
		& sudo softwareupdate -i -a
	}
	if (Get-Command microsoftstore -errorAction SilentlyContinue) {
		Write-Host "`n⏳ Installing updates from Microsoft Store..." -foregroundColor blue
		& microsoftstore updates --apply
	}
	elseif (Get-Command winget -errorAction SilentlyContinue) {
		Write-Host "`n⏳ Upgrading apps from Microsoft Store..." -foregroundColor blue
		& winget upgrade --all --source=msstore --include-unknown
	}
	if (Get-Command winget -errorAction SilentlyContinue) {
		Write-Host "`n⏳ Upgrading apps from WinGet..." -foregroundColor blue
		& winget upgrade --all --source=winget --include-unknown
	}
	if (Get-Command choco -errorAction SilentlyContinue) {
		Write-Host "`n⏳ Upgrading by Chocolatey..." -foregroundColor blue
		& choco upgrade all -y
	}
	[int]$elapsed = $stopWatch.Elapsed.TotalSeconds
	Write-Host "✅ Updates installed in $($elapsed)s.   " -noNewline
	& "$PSScriptRoot/check-pending-reboot.ps1"
	exit 0 # success
} catch {
	"⚠️ ERROR: $($Error[0]) (in script line $($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
```

*(page generated from script by convert-ps2md.ps1 as of 11/16/2026 17:46:02)*
