<#
.SYNOPSIS
	Installs a SSH server (needs admin rights)
.DESCRIPTION
	This PowerShell script installs a SSH server (needs admin rights).
.EXAMPLE
	PS> ./install-ssh-server.ps1
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

#Requires -RunAsAdministrator

try {
	$StopWatch = [system.diagnostics.stopwatch]::startNew()

	if ($IsLinux) {
		& sudo apt install openssh-server
	} else {
		# Install the OpenSSH Server
		Add-WindowsCapability -Online -Name OpenSSH.Server~~~~0.0.1.0

		# Start the sshd service
		Start-Service sshd

		# OPTIONAL but recommended:
		Set-Service -Name sshd -StartupType 'Automatic'

		# Confirm the firewall rule is configured. It should be created automatically by setup.
		Get-NetFirewallRule -Name *ssh*

		# There should be a firewall rule named "OpenSSH-Server-In-TCP", which should be enabled
		# If the firewall does not exist, create one
		New-NetFirewallRule -Name sshd -DisplayName 'OpenSSH Server (sshd)' -Enabled True -Direction Inbound -Protocol TCP -Action Allow -LocalPort 22
	}

	[int]$Elapsed = $StopWatch.Elapsed.TotalSeconds
	"✔️ installed and started SSH server in $Elapsed sec"
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
