<#
.SYNOPSIS
	Say an answer to 'thank you'
.DESCRIPTION
	This script answers to "thank you" by text-to-speech (TTS).
.EXAMPLE
	PS> ./thank-you
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

try {
	& "$PSScriptRoot/speak-english.ps1" "It's a pleasure."
	exit 0 # success
} catch {
	"⚠️ Error: $($Error[0]) ($($MyInvocation.MyCommand.Name):$($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
