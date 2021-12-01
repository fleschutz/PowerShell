<#
.SYNOPSIS
	Checks the health of the local computer
.DESCRIPTION
	This script checks the health of the local computer.
.EXAMPLE
	PS> ./check-health
	✔️ 1213 GB left for swap space (67 of 1280 GB used)
	✔️ 172 GB left on drive C (61 of 233 GB used)
	✔️ 30.3 °C CPU temperature - good
	✔️ DNS resolution is 19.7 domains per second
	✔️ 29 ms ping average (13 ms min, 110 ms max, 10 hosts)
	✔️ Windmill is healthy
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author:  Markus Fleschutz
	License: CC0
#>

& "$PSScriptRoot/check-swap-space.ps1"
if ($lastExitCode -ne "0") { $Healthy = 0 }

if ($IsLinux) {
	& "$PSScriptRoot/check-drive-space.ps1" /
	if ($lastExitCode -ne "0") { $Healthy = 0 }
} else {
	& "$PSScriptRoot/check-drive-space.ps1" C
	if ($lastExitCode -ne "0") { $Healthy = 0 }
}

& "$PSScriptRoot/check-cpu.ps1"
& "$PSScriptRoot/check-dns.ps1"
& "$PSScriptRoot/check-ping.ps1"
if ($IsLinux) {
	& "$PSScriptRoot/check-smart-devices.ps1" 
	if ($lastExitCode -ne "0") { $Healthy = 0 }
}
exit 0 # success
