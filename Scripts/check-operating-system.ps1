<#
.SYNOPSIS
	Determines the exact OS version 
.DESCRIPTION
	This PowerShell script determines and lists the exact operating system version.
.EXAMPLE
	PS> ./check-operating-system
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

try {
	if ($IsLinux) {
		$Summary = (uname -sr)
	} else {
		[system.threading.thread]::currentthread.currentculture = [system.globalization.cultureinfo]"en-US"
		$OS = Get-WmiObject -class Win32_OperatingSystem
		$Name = $OS.Caption
		$Architecture = $OS.OSArchitecture
		$Version = $OS.Version

	      $OSDetails = Get-CimInstance Win32_OperatingSystem
	      $InstallDate = $OSDetails.InstallDate
		$Summary = "$Name for $Architecture v$Version, installed on $($InstallDate.ToShortDateString())"
	} 
	"✅ Running $Summary."
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
