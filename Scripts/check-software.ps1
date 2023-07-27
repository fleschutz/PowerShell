<#
.SYNOPSIS
	Checks the software
.DESCRIPTION
	This PowerShell script queries the software details of the local computer and prints it.
.EXAMPLE
	PS> ./check-software.ps1

	S O F T W A R E
	✅ BIOS 'P62 v02.67', release HPQOEM - 0, S/N CZC448B9C1 by HP
	...
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

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
exit 0 # success