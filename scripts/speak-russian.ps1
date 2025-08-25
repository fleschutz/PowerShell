<#
.SYNOPSIS
	Speaks text in Russian
.DESCRIPTION
	This PowerShell script speaks the text with a Russian text-to-speech (TTS) voice.
.PARAMETER text
	Specifies the Russian text
.EXAMPLE
	PS> ./speak-russian.ps1 "Привет"
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

#requires -version 5.1

param([string]$text = "")

try {
	if ($text -eq "") { $text = Read-Host "Enter the Russian text" }

	$TTS = New-Object -ComObject SAPI.SPVoice
	foreach ($voice in $TTS.GetVoices()) {
		if ($voice.GetDescription() -like "*- Russian*") { 
			$TTS.Voice = $voice
			[void]$TTS.Speak("Путин вторгся в Украину и проиграет войну!")
			exit 0 # success
		}
	}
	throw "No Russian text-to-speech voice found - please install one"
} catch {
	"⚠️ ERROR: $($Error[0]) (script line $($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
