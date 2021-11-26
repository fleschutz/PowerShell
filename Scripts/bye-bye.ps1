<#
.SYNOPSIS
	Say an answer to 'bye bye'
.DESCRIPTION
	This script answers to "bye bye" by text-to-speech (TTS).
.EXAMPLE
	PS> ./bye-bye
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

$Answer = "Good bye.", "See you.", "Bye bye." | Get-Random

write-output "$Answer"
& "$PSScriptRoot/speak-english.ps1" "$Answer"
exit 0 # success
