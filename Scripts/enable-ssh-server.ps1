<#
.SYNTAX       enable-ssh-server.ps1
.DESCRIPTION  enables the SSH server (needs admin rights)
.LINK         https://github.com/fleschutz/PowerShell
.NOTES        Author: Markus Fleschutz / License: CC0
#>

#Requires -RunAsAdministrator

try {
	Add-WindowsCapability -Online -Name OpenSSH.Server*
	Start-Service sshd
	Set-Service -Name sshd -StartupType 'Automatic'

	write-host -foregroundColor green "OK - SSH server enabled"
	exit 0
} catch {
	write-error "⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
