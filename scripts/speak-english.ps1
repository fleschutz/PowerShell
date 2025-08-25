<#
.SYNOPSIS
	Speaks text in English
.DESCRIPTION
	This PowerShell script speaks the given text with an English text-to-speech (TTS) voice.
.PARAMETER text
	Specifies the English text to speak
.EXAMPLE
	PS> ./speak-english.ps1 Hi
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

#requires -version 5.1

param([string]$text = "")

try {
	if ($text -eq "") { $text = Read-Host "Enter the English text to speak" }

	$TTS = New-Object -ComObject SAPI.SPVoice
	foreach ($voice in $TTS.GetVoices()) {
		if ($voice.GetDescription() -like "*- English*") {
			$TTS.Voice = $voice
		}
	}
	[void]$TTS.Speak($text)
	exit 0 # success
} catch {
	"⚠️ ERROR: $($Error[0]) (script line $($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
