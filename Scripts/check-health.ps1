<#
.SYNOPSIS
	Checks the computer health 
.DESCRIPTION
	This PowerShell script checks the health of the local computer.
.EXAMPLE
	PS> ./check-health
	✔️ 1213 GB left for swap space (67 of 1280 GB used)
	✔️ 172 GB left on drive C (61 of 233 GB used)
	✔️ 30.3 °C CPU temperature - good
	✔️ DNS resolution is 19.7 domains per second
	✔️ 29 ms ping average (13 ms min, 110 ms max, 10 hosts)
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz / License: CC0
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
exit 0 # success
