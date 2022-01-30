<#
.SYNOPSIS
	Speaks a countdown by text-to-speech
.DESCRIPTION
	This PowerShell script speaks a countdown starting from a given number (10 by default) by text-to-speech (TTS).
.PARAMETER StartNumber
	Specifies the number to start from
.EXAMPLE
	PS> ./speak-countdown 60
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz / License: CC0
#>

param([int]$StartNumber = 10)

try {
	for ([int]$i = $StartNumber; $i -gt 0; $i--) {
		& "$PSScriptRoot/give-reply.ps1" $i
		start-sleep -milliseconds 200
	}
	& "$PSScriptRoot/give-reply.ps1" "zero"
	exit 0 # success
} catch {
	"⚠️ Error: $($Error[0]) ($($MyInvocation.MyCommand.Name):$($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
