<#
.SYNOPSIS
	install-wsl.ps1
.DESCRIPTION
	Installs Windows Subsystem for Linux (WSL) - needs admin rights
.EXAMPLE
	PS> ./install-wsl
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
		"👉 Step 1/3: Enable WSL..."
		& dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart

		"👉 Step 2/3: Enable virtual machine platform..."
		& dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart

		"👉 Step 3/3: Enable WSL version 2..."
		& wsl --set-default-version 2
	}

	[int]$Elapsed = $StopWatch.Elapsed.TotalSeconds
	"✔️ installed Windows Subsystem for Linux (WSL) in $Elapsed sec"
	"  NOTE: reboot now, then visit the Microsoft Store and install a Linux distribution (e.g. Ubuntu, openSUSE, SUSE Linux, Kali Linux, Debian, Fedora, Pengwin, or Alpine)"
	exit 0 # success
} catch {
	"⚠️ Error: $($Error[0]) ($($MyInvocation.MyCommand.Name):$($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
