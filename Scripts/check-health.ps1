#!/bin/powershell
<#
.SYNTAX       ./check-health.ps1 
.DESCRIPTION  checks the system health
.LINK         https://github.com/fleschutz/PowerShell
.NOTES        Author: Markus Fleschutz / License: CC0
#>

$Hostname = $(hostname)
$Healthy = 1
"Checking health of $Hostname ..."

& check-swap-space.ps1
if ($lastExitCode -ne "0") { $Healthy = 0 }

if ($IsLinux) {
	& check-drive-space.ps1 /
	if ($lastExitCode -ne "0") { $Healthy = 0 }
} else {
	& check-drive-space.ps1 C
	if ($lastExitCode -ne "0") { $Healthy = 0 }
}

& check-cpu-temp.ps1
if ($lastExitCode -ne "0") { $Healthy = 0 }

if (-not($IsLinux)) {
	& check-windows-system-files.ps1
	if ($lastExitCode -ne "0") { $Healthy = 0 }
}

& check-dns-resolution.ps1
if ($lastExitCode -ne "0") { $Healthy = 0 }

& check-ping.ps1
if ($lastExitCode -ne "0") { $Healthy = 0 }

if ($Healthy) {
	write-host -foregroundColor green "OK - $Hostname is healthy"
	exit 0
} else {
	write-warning "$Hostname is NOT healthy"
	exit 1
}
