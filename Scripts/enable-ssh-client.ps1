<#
.SYNTAX       enable-ssh-client.ps1
.DESCRIPTION  enables the SSH client (needs admin rights)
.LINK         https://github.com/fleschutz/PowerShell
.NOTES        Author: Markus Fleschutz / License: CC0
#>

#Requires -RunAsAdministrator

try {
	Add-WindowsCapability -Online -Name OpenSSH.Client*

	write-host -foregroundColor green "OK - SSH client enabled"
	exit 0
} catch {
	write-error "⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
