<#
.SYNOPSIS
	Checks the earth (fun)
.DESCRIPTION
	This script checks the earth and replies by text-to-speech (TTS).
.EXAMPLE
	PS> ./check-earth
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

try {
	& "$PSScriptRoot/speak-english.ps1" "Earth still spins with 1040mph."
	exit 0 # success
} catch {
	"⚠️ Error: $($Error[0]) ($($MyInvocation.MyCommand.Name):$($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
