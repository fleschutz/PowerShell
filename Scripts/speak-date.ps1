<#
.SYNTAX       speak-date.ps1
.DESCRIPTION  speaks the current date by text-to-speech (TTS)
.LINK         https://github.com/fleschutz/PowerShell
.NOTES        Author: Markus Fleschutz / License: CC0
#>

try {
	[system.threading.thread]::currentthread.currentculture=[system.globalization.cultureinfo]"en-US"
	& "$PSScriptRoot/speak-english.ps1" "Today is $((Get-Date).ToShortDateString())"
	exit 0
} catch {
	write-error "⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
