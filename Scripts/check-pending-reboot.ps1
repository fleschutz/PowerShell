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

$Reason = ""

if (Test-Path -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\Auto Update\RebootRequired") {
	$Reason += ", found 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\Auto Update\RebootRequired' in registry"
}
if (Test-Path -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\Auto Update\PostRebootReporting") {
	$Reason += ", found 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\Auto Update\PostRebootReporting' in registry"
}
if (Test-Path -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Component Based Servicing\RebootPending") {
	$Reason += ", found 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Component Based Servicing\RebootPending' in registry"
}
if (Test-Path -Path "HKLM:\SOFTWARE\Microsoft\ServerManager\CurrentRebootAttempts") {
	$Reason += ", found 'HKLM:\SOFTWARE\Microsoft\ServerManager\CurrentRebootAttempts' in registry"
}
if (Test-RegistryValue -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\Component Based Servicing" -Value "RebootInProgress") {
	$Reason += ", found 'HKLM:\Software\Microsoft\Windows\CurrentVersion\Component Based Servicing' with 'RebootInProgress' in registry"
}
if (Test-RegistryValue -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\Component Based Servicing" -Value "PackagesPending") {
	$Reason += ", found 'HKLM:\Software\Microsoft\Windows\CurrentVersion\Component Based Servicing' with 'PackagesPending' in registry"
}
#if (Test-RegistryValue -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager" -Value "PendingFileRenameOperations") {
#	$Reason += ", found 'HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager' with 'PendingFileRenameOperations' in registry"
#}
if (Test-RegistryValue -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager" -Value "PendingFileRenameOperations2") {
	$Reason += ", found 'HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager' with 'PendingFileRenameOperations2' in registry"
}
if (Test-RegistryValue -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\RunOnce" -Value "DVDRebootSignal") {
	$Reason += ", found 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\RunOnce' with 'DVDRebootSignal' in registry"
}
if (Test-RegistryValue -Path "HKLM:\SYSTEM\CurrentControlSet\Services\Netlogon" -Value "JoinDomain") {
	$Reason += ", found 'HKLM:\SYSTEM\CurrentControlSet\Services\Netlogon' with 'JoinDomain' in registry"
}
if (Test-RegistryValue -Path "HKLM:\SYSTEM\CurrentControlSet\Services\Netlogon" -Value "AvoidSpnSet") {
	$Reason += ", found 'HKLM:\SYSTEM\CurrentControlSet\Services\Netlogon' with 'AvoidSpnSet' in registry"
}
if ($Reason -ne "") {
	"⚠️ Pending reboot ($($Reason.substring(2)))."	
} else {
	"✅ No pending reboot."
}
exit 0 # success