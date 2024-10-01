<#
.SYNOPSIS
	SSH login to another host
.DESCRIPTION
	This PowerShell script logs into another host by SSH.
.PARAMETER hostName
	Specifies the hostname or IP address
.EXAMPLE
	PS> ./enter.ps1 linuxhost
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

param([string]$hostName = "")

try {
	if ($hostName -eq "") { $hostName = Read-Host "Enter the target hostname" }
	if ($IsLinux) { $username = $(whoami) } else { $username = $env:USERNAME }

	Write-Host "Entering host '$hostName' as user '$username' using " -noNewline
	& ssh -V
	& ssh "$($username)@$($hostName)"
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
