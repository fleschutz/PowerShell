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
	$Reason += "found registry key 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\Auto Update\RebootRequired' "
}
if (Test-Path -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\Auto Update\PostRebootReporting") {
	$Reason += "found registry key 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\Auto Update\PostRebootReporting' "
}
if (Test-Path -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Component Based Servicing\RebootPending") {
	$Reason += "found registry key 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Component Based Servicing\RebootPending' "
}
if (Test-Path -Path "HKLM:\SOFTWARE\Microsoft\ServerManager\CurrentRebootAttempts") {
	$Reason += "found registry key 'HKLM:\SOFTWARE\Microsoft\ServerManager\CurrentRebootAttempts' "
}
if (Test-RegistryValue -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\Component Based Servicing" -Value "RebootInProgress") {
	$Reason += "registry 'HKLM:\Software\Microsoft\Windows\CurrentVersion\Component Based Servicing' = 'RebootInProgress' "
}
if (Test-RegistryValue -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\Component Based Servicing" -Value "PackagesPending") {
	$Reason += "registry 'HKLM:\Software\Microsoft\Windows\CurrentVersion\Component Based Servicing' = 'PackagesPending' "
}
if (Test-RegistryValue -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager" -Value "PendingFileRenameOperations") {
	$Reason += "registry 'HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager' = 'PendingFileRenameOperations' "
}
if (Test-RegistryValue -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager" -Value "PendingFileRenameOperations2") {
	$Reason += "registry 'HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager' = 'PendingFileRenameOperations2' "
}
if (Test-RegistryValue -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\RunOnce" -Value "DVDRebootSignal") {
	$Reason += "registry 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\RunOnce' = 'DVDRebootSignal' "
}
if (Test-RegistryValue -Path "HKLM:\SYSTEM\CurrentControlSet\Services\Netlogon" -Value "JoinDomain") {
	$Reason += "registry 'HKLM:\SYSTEM\CurrentControlSet\Services\Netlogon' = 'JoinDomain' "
}
if (Test-RegistryValue -Path "HKLM:\SYSTEM\CurrentControlSet\Services\Netlogon" -Value "AvoidSpnSet") {
	$Reason += "registry 'HKLM:\SYSTEM\CurrentControlSet\Services\Netlogon' = 'AvoidSpnSet' "
}
if ($Reason -eq "") {
	"✅ No pending reboot."
} else {
	"⚠️ Pending reboot ($Reason)."
}
exit 0 # success