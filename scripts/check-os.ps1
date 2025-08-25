<#
.SYNOPSIS
	Checks the OS status
.DESCRIPTION
	This PowerShell script queries the operating system status and prints it.
.EXAMPLE
	PS> ./check-os.ps1
	✅ Windows 10 Pro 64-bit since 6/22/2021 (v10.0.19045, S/N 00123-45678-15135-AAOEM, P/K AB123-CD456-EF789-GH000-WFR6P)
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

try {
	if ($IsLinux) {
		$Name = $PSVersionTable.OS
		if ([System.Environment]::Is64BitOperatingSystem) { $Arch = "64-bit" } else { $Arch = "32-bit" }
		Write-Host "✅ $Name (Linux $Arch)"
	} else {
		$OS = Get-WmiObject -class Win32_OperatingSystem
		$Name = $OS.Caption -Replace "Microsoft Windows","Windows"
		$Arch = $OS.OSArchitecture
		$Version = $OS.Version

		[system.threading.thread]::currentthread.currentculture = [system.globalization.cultureinfo]"en-US"
		$OSDetails = Get-CimInstance Win32_OperatingSystem
		$BuildNo = $OSDetails.BuildNumber
		$Serial = $OSDetails.SerialNumber
		$InstallDate = $OSDetails.InstallDate

		$ProductKey = (Get-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\SoftwareProtectionPlatform" -Name BackupProductKeyDefault).BackupProductKeyDefault
		Write-Host "✅ $Name $Arch since $($InstallDate.ToShortDateString()) (v$Version, S/N $Serial, P/K $ProductKey)"
	} 
	exit 0 # success
} catch {
	"⚠️ ERROR: $($Error[0]) (script line $($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
