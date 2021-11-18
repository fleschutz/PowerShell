<#
.SYNOPSIS
	Say an answer to 'how are you?'
.DESCRIPTION
	This script answers "how are you?" by text-to-speech (TTS).
.EXAMPLE
	PS> ./how-are-you
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

try {
	& "$PSScriptRoot/speak-english.ps1" "I'm fine, thanks."
	exit 0 # success
} catch {
	"⚠️ Error: $($Error[0]) ($($MyInvocation.MyCommand.Name):$($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
