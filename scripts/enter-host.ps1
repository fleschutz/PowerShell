<#
.SYNOPSIS
	Enter another host via SSH
.DESCRIPTION
	This PowerShell script logs into a remote host via secure shell (SSH).
.PARAMETER remoteHost
	Specifies the remote hostname or IP address
.EXAMPLE
	PS> ./enter-host.ps1 tux
	✅ 'tux' is online with 3ms ping to it's IP 192.168.1.179
	⏳ Connecting as user 'markus' with OpenSSH_for_Windows_9.5p1, LibreSSL 3.8.2
	markus@tux's password:
	...
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

param([string]$remoteHost = "")

try {
	if ($remoteHost -eq "") {
		$remoteHost = Read-Host "Enter the remote hostname or IP address"
		$remoteUser = Read-Host "Enter the username at $remoteHost"
	} elseif ($IsLinux) {
		$remoteUser = $(whoami)
	} else {
		$remoteUser = $env:USERNAME
		$remoteUser = $remoteUser.toLower()
	}

	& "$PSScriptRoot/ping-host.ps1" $remoteHost
	if ($lastExitCode -ne 0) {
		Write-Host "Let's try to wake '$remoteHost' up..."
		& "$PSScriptRoot/wake-up-host.ps1" 
	}

	Write-Host "⏳ Connecting as user '$remoteUser' with " -noNewline
	& ssh -V
	if ($lastExitCode -ne 0) { throw "'ssh -V' failed with exit code $lastExitCode" }

	& ssh "$($remoteUser)@$($remoteHost)"
	exit 0 # success
} catch {
	"⚠️ ERROR: $($Error[0]) (script line $($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
