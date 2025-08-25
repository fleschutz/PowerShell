<#
.SYNOPSIS
	Speaks a countdown by text-to-speech
.DESCRIPTION
	This PowerShell script speaks a countdown by text-to-speech (TTS) starting from a given number.
.PARAMETER startNumber
	Specifies the number to start from (10 by default)
.EXAMPLE
	PS> ./speak-countdown.ps1 60
	(listen and enjoy)
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

#requires -version 5.1

param([int]$startNumber = 10)

try {
	for ([int]$i = $startNumber; $i -gt 0; $i--) {
		& "$PSScriptRoot/speak-english.ps1" $i
		Start-Sleep -milliseconds 200
	}
	& "$PSScriptRoot/speak-english.ps1" "Zero and lift-off!"
	exit 0 # success
} catch {
	"⚠️ ERROR: $($Error[0]) (script line $($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
