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
		$Details = (uname -sr)
	} else {
		$OS = Get-WmiObject -class Win32_OperatingSystem
		$OSname = $OS.Caption
		$OSarchitecture = $OS.OSArchitecture
		$OSversion = $OS.Version
		$Details = "$OSname for $OSarchitecture version $OSversion"
	} 
	"✅ Running $Details."
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
