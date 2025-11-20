<#
.SYNOPSIS
	Reboots into BIOS (needs admin rights)
.DESCRIPTION
	This PowerShell script reboots the local computer immediately into BIOS (needs admin rights).
.EXAMPLE
	PS> ./reboot-into-bios.ps1
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

#Requires -RunAsAdministrator

# Requires admin privileges to run
if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
	Write-Host "This script requires administrative privileges." -ForegroundColor Red
	Write-Host "Please run PowerShell as Administrator and try again." -ForegroundColor Yellow
	pause
	exit 1
}

try {
	Write-Host "Preparing to reboot into BIOS/UEFI..." -foregroundColor Yellow
    
	# Get boot configuration
	$bootConfig = bcdedit /enum firmware
	if ($lastExitCode -ne 0) { throw "Failed to get boot configuration" }

	# Set the one-time boot to UEFI
	$result = shutdown /r /fw /t 0
	if ($lastExitCode -ne 0) { throw "Failed to initiate reboot" }

	exit 0 # success
} catch {
	"⚠️ ERROR: $($Error[0]) (script line $($_.InvocationInfo.ScriptLineNumber))"
	pause
	exit 1
}
