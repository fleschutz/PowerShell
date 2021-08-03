<#
.SYNOPSIS
	install-ssh-client.ps1
.DESCRIPTION
	Installs the SSH client (needs admin rights)
.EXAMPLE
	PS> .\install-ssh-client.ps1
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author:  Markus Fleschutz
	License: CC0
#>

#Requires -RunAsAdministrator

try {
	$StopWatch = [system.diagnostics.stopwatch]::startNew()

	Add-WindowsCapability -Online -Name OpenSSH.Client*

	[int]$Elapsed = $StopWatch.Elapsed.TotalSeconds
	"✔️ installed SSH client in $Elapsed sec"
	exit 0
} catch {
	write-error "⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
