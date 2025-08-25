<#
.SYNOPSIS
	Check for pending reboots
.DESCRIPTION
	This PowerShell script queries pending operating system reboots and prints it.
.EXAMPLE
	./check-pending-reboot.ps1
	✅ No pending reboot.
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

try {
	[string]$reply = "✅ No pending reboot."
	if ($IsLinux) {
		if (Test-Path "/var/run/reboot-required") {
			$reply = "⚠️ Pending reboot (found: /var/run/reboot-required)"
		}
	} else {
		$reason = ""
		if (Test-Path -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\Auto Update\RebootRequired") {
			$reason += ", ...\Auto Update\RebootRequired"
		}
		if (Test-Path -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\Auto Update\PostRebootReporting") {
			$reason += ", ...\Auto Update\PostRebootReporting"
		}
		if (Test-Path -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Component Based Servicing\RebootPending") {
			$reason += ", ...\Component Based Servicing\RebootPending"
		}
		if (Test-Path -Path "HKLM:\SOFTWARE\Microsoft\ServerManager\CurrentRebootAttempts") {
			$reason += ", ...\ServerManager\CurrentRebootAttempts"
		}
		if (Test-RegistryValue -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\Component Based Servicing" -Value "RebootInProgress") {
			$reason += ", ...\CurrentVersion\Component Based Servicing with 'RebootInProgress'"
		}
		if (Test-RegistryValue -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\Component Based Servicing" -Value "PackagesPending") {
			$reason += ", '...\CurrentVersion\Component Based Servicing' with 'PackagesPending'"
		}
		if (Test-RegistryValue -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager" -Value "PendingFileRenameOperations2") {
			$reason += ", '...\CurrentControlSet\Control\Session Manager' with 'PendingFileRenameOperations2'"
		}
		if (Test-RegistryValue -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\RunOnce" -Value "DVDRebootSignal") {
			$reason += ", '...\Windows\CurrentVersion\RunOnce' with 'DVDRebootSignal'"
		}
		if (Test-RegistryValue -Path "HKLM:\SYSTEM\CurrentControlSet\Services\Netlogon" -Value "JoinDomain") {
			$reason += ", '...\CurrentControlSet\Services\Netlogon' with 'JoinDomain'"
		}
		if (Test-RegistryValue -Path "HKLM:\SYSTEM\CurrentControlSet\Services\Netlogon" -Value "AvoidSpnSet") {
			$reason += ", '...\CurrentControlSet\Services\Netlogon' with 'AvoidSpnSet'"
		}
		if ($reason -ne "") {
			$reply = "⚠️ Pending reboot (registry has $($reason.substring(2)))"
		}
	}
	Write-Host $reply
	exit 0 # success
} catch {
	"⚠️ ERROR: $($Error[0]) (script line $($_.InvocationInfo.ScriptLineNumber))"
        exit 1
}
