<#
.SYNOPSIS
	Tells the OS version by text-to-speech
.DESCRIPTION
	This script speaks the operating system version by text-to-speech (TTS).
.EXAMPLE
	PS> ./tell-operating-system
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

try {
	if ($IsLinux) {
		$Answer = (uname -sr)
	} else {
		$OS = Get-WmiObject -class Win32_OperatingSystem
		$OSname = $OS.Caption
		$OSarchitecture = $OS.OSArchitecture
		$OSversion = $OS.Version
		$Answer = "$OSname for $OSarchitecture version $OSversion"
	} 
	& "$PSScriptRoot/speak-english.ps1" "$Answer"
	write-output "$Answer"
	exit 0 # success
} catch {
	"⚠️ Error: $($Error[0]) ($($MyInvocation.MyCommand.Name):$($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
