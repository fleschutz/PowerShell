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

$Answer = "It's a pleasure.", "Never mind." | Get-Random

write-output "$Answer"
& "$PSScriptRoot/speak-english.ps1" "$Answer"
exit 0 # success
