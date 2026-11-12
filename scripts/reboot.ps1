<#
.SYNOPSIS
	Reboots the computer (needs admin rights)
.DESCRIPTION
	This PowerShell script reboots the local computer immediately (needs admin rights).
.EXAMPLE
	PS> ./reboot.ps1
	⏳ Checking requirements...
	...
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

#Requires -RunAsAdministrator

try {
	Write-Host "⏳ Checking requirements..."
	& "$PSScriptRoot/check-power.ps1"
	if ($IsLinux -or $IsMacOS) {
		& "$PSScriptRoot/check-drive-space.ps1" /
	} else {
		& "$PSScriptRoot/check-drive-space.ps1" C
	}
	Start-Sleep -seconds 3

	Write-Host "⏳ Rebooting now, please wait..."
	if ($IsLinux) {
		& sudo reboot
	} else {
		Restart-Computer
	}
	exit 0 # success
} catch {
	"⚠️ ERROR: $($Error[0]) (in script line $($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
