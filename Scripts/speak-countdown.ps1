<#
.SYNOPSIS
	speak-countdown.ps1 [start-number]
.DESCRIPTION
	Speaks a countdown by text-to-speech (TTS)
.EXAMPLE
	PS> .\speak-countdown.ps1 60
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz / License: CC0
#>

param([int]$StartNumber = 10)

try {
	for ([int]$i = $StartNumber; $i -gt 0; $i--) {
		& "$PSScriptRoot/speak-english.ps1" $i
		start-sleep -milliseconds 200
	}
	& "$PSScriptRoot/speak-english.ps1" "zero"
	exit 0
} catch {
	write-error "⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
