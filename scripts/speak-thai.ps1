<#
.SYNOPSIS
	Speaks text in Thai
.DESCRIPTION
	This PowerShell script speaks the given text with a Thai text-to-speech (TTS) voice.
.PARAMETER text
	Specifies the Thai text to speak
.EXAMPLE
	PS> ./speak-thai.ps1 "สวัสดี"
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

#requires -version 5.1

param([string]$text = "")

try {
	if ($text -eq "") { $text = Read-Host "Enter the Thai text to speak" }

	$TTS = New-Object -ComObject SAPI.SPVoice
	foreach ($voice in $TTS.GetVoices()) {
		if ($voice.GetDescription() -like "*- Thai*") {
			$TTS.Voice = $voice
			[void]$TTS.Speak($text)
			exit 0 # success
		}
	}
	throw "No Thai text-to-speech voice found - please install one."
} catch {
	"⚠️ ERROR: $($Error[0]) (script line $($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
