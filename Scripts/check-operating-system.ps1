<#
.SYNOPSIS
	Query OS details
.DESCRIPTION
	This PowerShell script queries and lists operating system details.
.EXAMPLE
	PS> ./check-operating-system
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

try {
	if ($IsLinux) {
		"✅ $(uname -sr)."
	} else {
		$OS = Get-WmiObject -class Win32_OperatingSystem
		$Name = $OS.Caption
		$Arch = $OS.OSArchitecture
		$Version = $OS.Version

		[system.threading.thread]::currentthread.currentculture = [system.globalization.cultureinfo]"en-US"
		$OSDetails = Get-CimInstance Win32_OperatingSystem
		$BuildNo = $OSDetails.BuildNumber
		$Serial = $OSDetails.SerialNumber
		$InstallDate = $OSDetails.InstallDate
		"✅ $($Name): $Arch, v$Version, S/N $Serial, installed $($InstallDate.ToShortDateString())"
	} 
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}