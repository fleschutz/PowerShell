<#
.SYNOPSIS
	Say an answer to 'good night'
.DESCRIPTION
	This script answers "good night" by text-to-speech (TTS).
.EXAMPLE
	PS> ./good-night
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

try {
	& "$PSScriptRoot/speak-english.ps1" "Good night to you, my friend."
	exit 0 # success
} catch {
	"⚠️ Error: $($Error[0]) ($($MyInvocation.MyCommand.Name):$($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
