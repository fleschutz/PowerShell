<#
.SYNOPSIS
	Lists the operating system version
.DESCRIPTION
	This PowerShell script lists the exact operating system version.
.EXAMPLE
	PS> ./list-os.ps1
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

try {
	if ($IsLinux) {
		"🐧(uname -sr)"
	} else {
		$OS = Get-WmiObject -class Win32_OperatingSystem
		$OSname = $OS.Caption
		$OSarchitecture = $OS.OSArchitecture
		$OSversion = $OS.Version
		"🌐$OSname for $OSarchitecture version $OSversion"
	}
	exit 0 # success
} catch {
	"⚠️ ERROR: $($Error[0]) (script line $($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
