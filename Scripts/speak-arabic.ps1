<#
.SYNOPSIS
	Speaks text in Arabic
.DESCRIPTION
	This PowerShell script speaks the given text with an Arabic text-to-speech (TTS) voice.
.PARAMETER text
	Specifies the Arabic text to speak
.EXAMPLE
	PS> ./speak-arabic.ps1 "أهلاً"
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

param([string]$text = "")

try {
	if ($text -eq "") { $text = Read-Host "Enter the Arabic text to speak" }

	$TTS = New-Object -ComObject SAPI.SPVoice
	foreach ($voice in $TTS.GetVoices()) {
		if ($voice.GetDescription() -like "*- Arabic*") { 
			$TTS.Voice = $voice
			[void]$TTS.Speak($text)
			exit 0 # success
		}
	}
	throw "No Arabic text-to-speech voice found - please install one"
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
