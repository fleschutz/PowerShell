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

& "$PSScriptRoot/speak-english.ps1" "Hasta la vista, baby."
exit 0 # success
