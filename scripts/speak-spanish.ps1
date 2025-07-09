﻿<#
.SYNOPSIS
	Speaks text in Spanish 
.DESCRIPTION
	This PowerShell script speaks the given text with a Spanish text-to-speech (TTS) voice.
.PARAMETER text
	Specifies the Spanish text to speak
.EXAMPLE
	PS> ./speak-spanish.ps1 Hola
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

#requires -version 5.1

param([string]$text = "")

try {
	if ($text -eq "") { $text = Read-Host "Enter the Spanish text to speak" }

	$TTS = New-Object -ComObject SAPI.SPVoice
	foreach ($voice in $TTS.GetVoices()) {
		if ($voice.GetDescription() -like "*- Spanish*") { 
			$TTS.Voice = $voice
			[void]$TTS.Speak($text)
			exit 0 # success
		}
	}
	throw "No Spanish text-to-speech voice found - please install one"
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
