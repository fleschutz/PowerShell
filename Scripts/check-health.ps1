<#
.SYNOPSIS
	Checks the system health 
.DESCRIPTION
	This PowerShell script checks and prints the system health of the local computer.
.EXAMPLE
	PS> ./check-health
	H A R D W A R E
	✅ Intel(R) Core(TM) i5-6400 CPU @ 2.70GHz (CPU0, 2701MHz, socket U3E1, 30.1°C)
	...
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

" "
& "$PSScriptRoot/write-green.ps1" "   H A R D W A R E"
& "$PSScriptRoot/check-cpu.ps1"
& "$PSScriptRoot/check-ram.ps1"
& "$PSScriptRoot/check-gpu.ps1"
& "$PSScriptRoot/check-smart-devices.ps1"
& "$PSScriptRoot/check-drives.ps1"
& "$PSScriptRoot/check-battery.ps1"
" "
& "$PSScriptRoot/write-green.ps1" "   S O F T W A R E"
& "$PSScriptRoot/check-bios.ps1"
& "$PSScriptRoot/check-os.ps1"
& "$PSScriptRoot/check-powershell.ps1"
& "$PSScriptRoot/check-apps.ps1"
& "$PSScriptRoot/check-uptime.ps1"
& "$PSScriptRoot/check-time-zone.ps1"
& "$PSScriptRoot/check-swap-space.ps1"
& "$PSScriptRoot/check-pending-reboot.ps1"
" "
& "$PSScriptRoot/write-green.ps1" "   N E T W O R K"
& "$PSScriptRoot/check-firewall"
& "$PSScriptRoot/check-ping.ps1"
& "$PSScriptRoot/check-dns.ps1"
& "$PSScriptRoot/check-vpn.ps1"
exit 0 # success