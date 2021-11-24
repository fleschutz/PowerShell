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
	$Answer = "Good night to you, too.", "Good night to you, my friend.", "Have a good night. Sleep well.", "Good night and sweet dreams." | Get-Random
	& "$PSScriptRoot/speak-english.ps1" "$Answer"
	exit 0 # success
} catch {
	"⚠️ Error: $($Error[0]) ($($MyInvocation.MyCommand.Name):$($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
