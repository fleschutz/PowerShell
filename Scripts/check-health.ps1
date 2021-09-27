<#
.SYNOPSIS
	check-health.ps1 
.DESCRIPTION
	Checks the health of the local computer
.EXAMPLE
	PS> ./check-health
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author:  Markus Fleschutz
	License: CC0
#>

$Hostname = $(hostname)
$Healthy = 1
"Checking $Hostname's health..."

& "$PSScriptRoot/check-swap-space.ps1"
if ($lastExitCode -ne "0") { $Healthy = 0 }

if ($IsLinux) {
	& "$PSScriptRoot/check-drive-space.ps1" /
	if ($lastExitCode -ne "0") { $Healthy = 0 }
} else {
	& "$PSScriptRoot/check-drive-space.ps1" C
	if ($lastExitCode -ne "0") { $Healthy = 0 }
}

& "$PSScriptRoot/check-cpu-temp.ps1"
if ($lastExitCode -ne "0") { $Healthy = 0 }

& "$PSScriptRoot/check-dns-resolution.ps1"
if ($lastExitCode -ne "0") { $Healthy = 0 }

& "$PSScriptRoot/check-ping.ps1"
if ($lastExitCode -ne "0") { $Healthy = 0 }

if ($Healthy) {
	"✔️ $Hostname is healthy"
	exit 0 # success
} else {
	write-warning "$Hostname is NOT healthy"
	exit 1
}
