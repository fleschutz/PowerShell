<#
.SYNOPSIS
	Answers to 'good night'
.DESCRIPTION
	This script answers to "good night" by text-to-speech (TTS).
.EXAMPLE
	PS> ./good-night
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

try {
	$Generator = New-Object System.Random
	$Answer = switch([int]$Generator.next(0, 3)) {
	0 { "Good night to you, too." }
	1 { "Good night to you, my friend." }
	2 { "Have a good night. Sleep well." }
	3 { "Good night and sweet dreams." }
	}
	& "$PSScriptRoot/speak-english.ps1" "$Answer"
	exit 0 # success
} catch {
	"⚠️ Error: $($Error[0]) ($($MyInvocation.MyCommand.Name):$($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
