<#
.SYNOPSIS
	Determines the exact OS version 
.DESCRIPTION
	This PowerShell script determines and says the exact operating system version by text-to-speech (TTS).
.EXAMPLE
	PS> ./check-operating-system
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz / License: CC0
#>

try {
	if ($IsLinux) {
		$Reply = (uname -sr)
	} else {
		$OS = Get-WmiObject -class Win32_OperatingSystem
		$OSname = $OS.Caption
		$OSarchitecture = $OS.OSArchitecture
		$OSversion = $OS.Version
		$Reply = "$OSname for $OSarchitecture version $OSversion"
	} 
	& "$PSScriptRoot/give-reply.ps1" "$Reply"
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
