<#
.SYNOPSIS
	Answers 'I'll be back'
.DESCRIPTION
	This script answers "I'll be back" by text-to-speech (TTS).
.EXAMPLE
	PS> ./i-will-be-back
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

$Answer = "Hasta la vista, baby."

& "$PSScriptRoot/speak-english.ps1" "$Answer"
write-output "$Answer"
exit 0 # success
