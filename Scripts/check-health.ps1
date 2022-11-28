<#
.SYNOPSIS
	Checks the system health 
.DESCRIPTION
	This PowerShell script checks some health parameter of the local computer.
.EXAMPLE
	PS> ./check-health
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

" "
"  ⭐️HARDWARE⭐️"
& "$PSScriptRoot/check-cpu.ps1"
& "$PSScriptRoot/check-ram.ps1"
& "$PSScriptRoot/check-gpu.ps1"
& "$PSScriptRoot/check-bios.ps1"
& "$PSScriptRoot/check-smart-devices.ps1"
& "$PSScriptRoot/check-drives.ps1"
" "
"  ⭐️SOFTWARE⭐️"
& "$PSScriptRoot/check-operating-system.ps1"
& "$PSScriptRoot/check-uptime.ps1"
& "$PSScriptRoot/check-time-zone.ps1"
& "$PSScriptRoot/check-swap-space.ps1"
& "$PSScriptRoot/check-dns.ps1"
& "$PSScriptRoot/check-ping.ps1"
& "$PSScriptRoot/check-vpn.ps1"
& "$PSScriptRoot/check-pending-reboot.ps1"
exit 0 # success
