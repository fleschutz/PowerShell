<#
.SYNOPSIS
	Checks the computer health 
.DESCRIPTION
	This PowerShell script checks some health parameter of the local computer.
.EXAMPLE
	PS> ./check-health
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

& "$PSScriptRoot/check-uptime.ps1"
& "$PSScriptRoot/check-operating-system.ps1"
& "$PSScriptRoot/check-swap-space.ps1"
& "$PSScriptRoot/check-drives.ps1"
& "$PSScriptRoot/check-cpu.ps1"
& "$PSScriptRoot/check-dns.ps1"
& "$PSScriptRoot/check-ping.ps1"
& "$PSScriptRoot/check-vpn.ps1"
if ($IsLinux) {
	& "$PSScriptRoot/check-smart-devices.ps1" 
}
& "$PSScriptRoot/check-pending-reboot.ps1"
exit 0 # success
