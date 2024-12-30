<#
.SYNOPSIS
	Checks the software
.DESCRIPTION
	This PowerShell script queries the software status of the local computer and prints it.
.EXAMPLE
	PS> ./check-software.ps1

	   === S O F T W A R E ===
	✅ Windows 10 Pro 64-Bit (v10.0.19045, since 5/2/2021)
	...
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

Write-Host "`n   === S O F T W A R E ===" -foregroundColor green
& "$PSScriptRoot/check-os.ps1"
& "$PSScriptRoot/check-uptime.ps1"
& "$PSScriptRoot/check-apps.ps1"
& "$PSScriptRoot/check-powershell.ps1"
& "$PSScriptRoot/check-time-zone.ps1"
& "$PSScriptRoot/check-swap-space.ps1"
exit 0 # success
