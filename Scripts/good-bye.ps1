<#
.SYNOPSIS
	Say an answer to 'good bye'
.DESCRIPTION
	This script answers to "good bye" by text-to-speech (TTS).
.EXAMPLE
	PS> ./good-bye
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

$Answer = "Good bye.", "See you." | Get-Random

write-output "$Answer"
& "$PSScriptRoot/speak-english.ps1" "$Answer"
exit 0 # success
