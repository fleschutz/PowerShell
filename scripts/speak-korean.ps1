<#
.SYNOPSIS
	Speaks text in Korean
.DESCRIPTION
	This PowerShell script speaks the given text with a Korean text-to-speech (TTS) voice.
.PARAMETER text
	Specifies the Korean text to speak
.EXAMPLE
	PS> ./speak-korean.ps1 "안녕하세요"
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

#requires -version 5.1

param([string]$text = "")

try {
	if ($text -eq "") { $text = Read-Host "Enter the Korean text to speak" }

	$TTS = New-Object -ComObject SAPI.SPVoice
	foreach ($voice in $TTS.GetVoices()) {
		if ($voice.GetDescription() -like "*- Korean*") {
			$TTS.Voice = $voice
			[void]$TTS.Speak($text)
			exit 0 # success
		}
	}
	throw "No Korean text-to-speech voice found - please install one."
} catch {
	"⚠️ ERROR: $($Error[0]) (script line $($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
