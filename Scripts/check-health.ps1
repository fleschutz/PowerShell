#!/bin/powershell
<#
.SYNTAX         ./check-health.ps1 
.DESCRIPTION	checks the system health
.LINK		https://github.com/fleschutz/PowerShell
.NOTES		Author:	Markus Fleschutz / License: CC0
#>

try {
	$Hostname = $(hostname)
	"Checking health of $Hostname ..."

	& check-swap-space.ps1
	if ($lastExitCode -ne "0") { throw "check-swap-space.ps1 failed" }

	if ($IsLinux) {
		& check-drive-space.ps1 /
		if ($lastExitCode -ne "0") { throw "check-drive-space.ps1 failed" }
	} else {
		& check-drive-space.ps1 C
		if ($lastExitCode -ne "0") { throw "check-drive-space.ps1 failed" }
	}

	& check-cpu-temp.ps1
	if ($lastExitCode -ne "0") { throw "check-cpu-temp.ps1 failed" }

	if (-not($IsLinux)) {
		& check-windows-system-files.ps1
		if ($lastExitCode -ne "0") { throw "check-windows-system-files.ps1 failed" }
	}

	& check-dns-resolution.ps1
	if ($lastExitCode -ne "0") { throw "check-dns-resolution.ps1 failed" }

	write-host -foregroundColor green "OK - $Hostname is healthy"
	exit 0
} catch {
	write-error "ERROR: line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
