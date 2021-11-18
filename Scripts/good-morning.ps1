<#
.SYNOPSIS
	Say an answer to 'good morning'
.DESCRIPTION
	This script answers "good morning" by text-to-speech (TTS).
.EXAMPLE
	PS> ./good-morning
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

try {
	& "$PSScriptRoot/speak-english.ps1" "Well, good morning to you too"
	exit 0 # success
} catch {
	"⚠️ Error: $($Error[0]) ($($MyInvocation.MyCommand.Name):$($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
