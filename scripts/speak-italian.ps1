﻿<#
.SYNOPSIS
	Speaks text in Italian 
.DESCRIPTION
	This PowerShell script speaks the given text with an Italian text-to-speech (TTS) voice.
.PARAMETER text
	Specifies the Italian text to speak
.EXAMPLE
	PS> ./speak-italian.ps1 Ciao
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

#requires -version 5.1

param([string]$text = "")

try {
	if ($text -eq "") { $text = Read-Host "Enter the Italian text to speak" }

	$TTS = New-Object -ComObject SAPI.SPVoice
	foreach ($voice in $TTS.GetVoices()) {
		if ($voice.GetDescription() -like "*- Italian*") {
			$TTS.Voice = $voice
			[void]$TTS.Speak($text)
			exit 0 # success
		}
	}
	throw "No Italian text-to-speech voice found - please install one."
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
