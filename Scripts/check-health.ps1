<#
.SYNTAX       check-health.ps1 
.DESCRIPTION  checks the health of the local computer
.LINK         https://github.com/fleschutz/PowerShell
.NOTES        Author: Markus Fleschutz / License: CC0
#>

$Hostname = $(hostname)
$Healthy = 1
"Checking health of $Hostname ..."

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
	exit 0
} else {
	write-warning "$Hostname is NOT healthy"
	exit 1
}
