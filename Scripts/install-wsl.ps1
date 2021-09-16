<#
.SYNOPSIS
	install-wsl.ps1
.DESCRIPTION
	Installs Windows Subsystem for Linux (WSL) - needs admin rights.
.EXAMPLE
	PS> .\install-wsl.ps1
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

#Requires -RunAsAdministrator

try {
	$StopWatch = [system.diagnostics.stopwatch]::startNew()

	if ($false) {

		& wsl --install

	} else {
		& dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart

		& dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart

		& wsl --set-default-version 2
	}

	[int]$Elapsed = $StopWatch.Elapsed.TotalSeconds
	"✔️ installed Windows Subsystem for Linux (WSL) in $Elapsed sec"
	"  NOTE: reboot now, then visit the Microsoft Store and install a Linux distribution (e.g. Ubuntu, openSUSE, SUSE Linux, Kali Linux, Debian, Fedora, Pengwin, or Alpine)"
	exit 0
} catch {
	"⚠️ Error: $($Error[0]) ($($MyInvocation.MyCommand.Name):$($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
