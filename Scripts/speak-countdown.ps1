<#
.SYNOPSIS
	speak-countdown.ps1 [start-number]
.DESCRIPTION
	Speaks a countdown by text-to-speech (TTS)
.EXAMPLE
	PS> ./speak-countdown 60
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
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
	"⚠️ Error: $($Error[0]) ($($MyInvocation.MyCommand.Name):$($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
