<#
.SYNOPSIS
	Enter another host via SSH
.DESCRIPTION
	This PowerShell script logs into a remote host via secure shell (SSH).
.PARAMETER remoteHost
	Specifies the remote hostname or IP address
.EXAMPLE
	PS> ./enter-host.ps1 tux
	💻 Entering 'tux' as user 'markus' using OpenSSH_for_Windows_9.5p1, LibreSSL 3.8.2
	...
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

param([string]$remoteHost = "")

try {
	if ($remoteHost -eq "") { $remoteHost = Read-Host "Enter the remote hostname" }
	if ($IsLinux) { $username = $(whoami) } else { $username = $env:USERNAME }
	$username = $username.toLower()

	Write-Host "💻 Entering '$remoteHost' as user '$username' using " -noNewline
	& ssh -V
	if ($lastExitCode -ne "0") { throw "'ssh -V' failed with exit code $lastExitCode" }
	Write-Host "                                        (type 'exit' to leave $remoteHost)"

	& ssh "$($username)@$($remoteHost)"
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
