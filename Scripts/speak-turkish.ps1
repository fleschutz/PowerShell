<#
.SYNOPSIS
	Speaks text in Turkish
.DESCRIPTION
	This PowerShell script speaks the given text with a Turkish text-to-speech (TTS) voice.
.PARAMETER text
	Specifies the Turkish text to speak
.EXAMPLE
	PS> ./speak-turkish.ps1 Merhaba
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

param([string]$text = "")

try {
	if ($text -eq "") { $text = Read-Host "Enter the Turkish text to speak" }

	$TTS = New-Object -ComObject SAPI.SPVoice
	foreach ($voice in $TTS.GetVoices()) {
		if ($voice.GetDescription() -like "*- Turkish*") { 
			$TTS.Voice = $voice
			[void]$TTS.Speak($text)
			exit 0 # success
		}
	}
	throw "No Turkish text-to-speech voice found - please install one"
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
