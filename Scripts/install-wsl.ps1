<#
.SYNOPSIS
	Installs Windows Subsystem for Linux (needs admin rights)
.DESCRIPTION
	This PowerShell script installs Windows Subsystem for Linux. It needs admin rights.
.EXAMPLE
	PS> ./install-wsl
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz / License: CC0
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
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
