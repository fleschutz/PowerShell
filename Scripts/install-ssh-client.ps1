<#
.SYNOPSIS
	install-ssh-client.ps1
.DESCRIPTION
	Installs the SSH client (needs admin rights).
.EXAMPLE
	PS> .\install-ssh-client.ps1
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

#Requires -RunAsAdministrator

try {
	$StopWatch = [system.diagnostics.stopwatch]::startNew()

	if ($IsLinux) {
		apt install openssh-client
	} else {
		Add-WindowsCapability -Online -Name OpenSSH.Client*
	}

	[int]$Elapsed = $StopWatch.Elapsed.TotalSeconds
	"✔️ installed SSH client in $Elapsed sec"
	exit 0
} catch {
	"⚠️ Error: $($Error[0]) ($($MyInvocation.MyCommand.Name):$($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
