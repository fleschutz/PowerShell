<#
.SYNOPSIS
	SSH login to another host
.DESCRIPTION
	This PowerShell script logs into another host by SSH.
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

	Write-Host "Entering remote host '$remoteHost' as user '$username' using " -noNewline
	& ssh -V
	& ssh "$($username)@$($remoteHost)"
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
