<#
.SYNOPSIS
	Say the operating system details by text-to-speech
.DESCRIPTION
	This script speaks the operating system details by text-to-speech (TTS).
.EXAMPLE
	PS> ./say-operating-system
	(listen)
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

try {
	if ($IsLinux) {
		$details = (uname -sr)
	} else {
		$OSname = Get-WmiObject -class Win32_OperatingSystem
		$OSarchitecture = $OS.OSArchitecture
		$OSversion = $OS.Version
		$details = "$OSname for $OSarchitecture version $OSversion"
	} 
	& "$PSScriptRoot/speak-english.ps1" "$details"
	exit 0 # success
} catch {
	"⚠️ Error: $($Error[0]) ($($MyInvocation.MyCommand.Name):$($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
