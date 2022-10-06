<#
.SYNOPSIS
	Check for pending reboots
.DESCRIPTION
	This PowerShell script checks different registry keys and values to determine if a reboot is pending.
.EXAMPLE
	./check-pending-reboot.ps1
.LINK
        https://github.com/fleschutz/PowerShell
.NOTES
        Author: Markus Fleschutz | License: CC0
#>

function Test-RegistryValue { param([parameter(Mandatory=$true)][ValidateNotNullOrEmpty()]$Path, [parameter(Mandatory=$true)] [ValidateNotNullOrEmpty()]$Value)
    try {
	Get-ItemProperty -Path $Path -Name $Value -EA Stop
	return $true
    } catch {
	return $false
    }
}

[bool]$PendingReboot = $false

if (Test-Path -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\Auto Update\RebootRequired") {
	"Yes, registry key 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\Auto Update\RebootRequired' is set."
	$PendingReboot = $true
}
if (Test-Path -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\Auto Update\PostRebootReporting") {
	"Yes, registry key 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\Auto Update\PostRebootReporting' is set."
	$PendingReboot = $true
}
if (Test-Path -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Component Based Servicing\RebootPending") {
	"Yes, registry key 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Component Based Servicing\RebootPending' is set."
	$PendingReboot = $true
}
if (Test-Path -Path "HKLM:\SOFTWARE\Microsoft\ServerManager\CurrentRebootAttempts") {
	"Yes, registry key 'HKLM:\SOFTWARE\Microsoft\ServerManager\CurrentRebootAttempts' is set."
	$PendingReboot = $true
}
if (Test-RegistryValue -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\Component Based Servicing" -Value "RebootInProgress") {
	"Yes, registry key 'HKLM:\Software\Microsoft\Windows\CurrentVersion\Component Based Servicing' contains 'RebootInProgress'."
	$PendingReboot = $true
}
if (Test-RegistryValue -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\Component Based Servicing" -Value "PackagesPending") {
	"Yes, registry key 'HKLM:\Software\Microsoft\Windows\CurrentVersion\Component Based Servicing' contains 'PackagesPending'."
	$PendingReboot = $true
}
if (Test-RegistryValue -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager" -Value "PendingFileRenameOperations") {
	"Yes, registry key 'HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager' contains 'PendingFileRenameOperations'."
	$PendingReboot = $true
}
if (Test-RegistryValue -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager" -Value "PendingFileRenameOperations2") {
	"Yes, registry key 'HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager' contains 'PendingFileRenameOperations2'."
	$PendingReboot = $true
}
if (Test-RegistryValue -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\RunOnce" -Value "DVDRebootSignal") {
	"Yes, registry key 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\RunOnce' contains 'DVDRebootSignal'."
	$PendingReboot = $true
}
if (Test-RegistryValue -Path "HKLM:\SYSTEM\CurrentControlSet\Services\Netlogon" -Value "JoinDomain") {
	"Yes, registry key 'HKLM:\SYSTEM\CurrentControlSet\Services\Netlogon' contains 'JoinDomain'."
	$PendingReboot = $true
}
if (Test-RegistryValue -Path "HKLM:\SYSTEM\CurrentControlSet\Services\Netlogon" -Value "AvoidSpnSet") {
	"Yes, registry key 'HKLM:\SYSTEM\CurrentControlSet\Services\Netlogon' contains 'AvoidSpnSet'."
	$PendingReboot = $true
}

if ($PendingReboot -eq $false) { "No pending reboot" }
exit 0 # success