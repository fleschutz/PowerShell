<#
.SYNOPSIS
	Login to another host via SSH
.DESCRIPTION
	This PowerShell script logs into a remote host via secure shell (SSH).
.PARAMETER remoteHost
	Specifies the remote hostname or IP address
.EXAMPLE
	PS> ./enter.ps1 linuxhost
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

	Write-Host "Trying to enter 💻$remoteHost as user '$username' using " -noNewline
	& ssh -V
	if ($lastExitCode -ne "0") { throw "'ssh -V' failed with exit code $lastExitCode" }

	& ssh "$($username)@$($remoteHost)"
	if ($lastExitCode -ne "0") { throw "'ssh -V' failed with exit code $lastExitCode" }
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
