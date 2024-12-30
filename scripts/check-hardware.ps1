<#
.SYNOPSIS
	Checks the hardware
.DESCRIPTION
	This PowerShell script queries the hardware details of the local computer and prints it.
.EXAMPLE
	PS> ./check-hardware.ps1
  
	   === H A R D W A R E ===
	✅ Intel(R) Core(TM) i5-6400 CPU @ 2.70GHz (CPU0, 2701MHz, socket U3E1, 30.1°C)
	...
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

Write-Host "`n   === H A R D W A R E ===" -foregroundColor green
& "$PSScriptRoot/check-cpu.ps1"
& "$PSScriptRoot/check-ram.ps1"
& "$PSScriptRoot/check-gpu.ps1"
& "$PSScriptRoot/check-motherboard.ps1"
& "$PSScriptRoot/check-bios.ps1"
& "$PSScriptRoot/check-smart-devices.ps1"
& "$PSScriptRoot/check-power.ps1"
& "$PSScriptRoot/check-drives.ps1"
exit 0 # success
