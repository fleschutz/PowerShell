<#
.SYNOPSIS
	Say an answer to 'good evening'
.DESCRIPTION
	This script answers "good evening" by text-to-speech (TTS).
.EXAMPLE
	PS> ./good-evening
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

try {
	& "$PSScriptRoot/speak-english.ps1" "And a special good evening to you too"
	exit 0 # success
} catch {
	"⚠️ Error: $($Error[0]) ($($MyInvocation.MyCommand.Name):$($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
