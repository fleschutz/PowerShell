#Requires -RunAsAdministrator
<#
.SYNOPSIS
	install-ssh-server.ps1
.DESCRIPTION
	Installs the SSH server (needs admin rights).
.EXAMPLE
	PS> .\install-ssh-server.ps1
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

try {
	$StopWatch = [system.diagnostics.stopwatch]::startNew()

	Add-WindowsCapability -Online -Name OpenSSH.Server*
	Start-Service sshd
	Set-Service -Name sshd -StartupType 'Automatic'

	[int]$Elapsed = $StopWatch.Elapsed.TotalSeconds
	"✔️ installed SSH server in $Elapsed sec"
	exit 0
} catch {
	write-error "⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
