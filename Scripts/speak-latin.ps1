<#
.SYNOPSIS
	Speaks text with a Latin text-to-speech voice
.DESCRIPTION
	This PowerShell script speaks the given text with a Latin text-to-speech (TTS) voice.
.PARAMETER text
	Specifies the text to speak
.EXAMPLE
	PS> ./speak-latin Salve
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz / License: CC0
#>

param([string]$text = "")

try {
	if ($text -eq "") { $text = read-host "Enter the Latin text to speak" }

	$TTSVoice = New-Object -ComObject SAPI.SPVoice
	foreach ($Voice in $TTSVoice.GetVoices()) {
		if ($Voice.GetDescription() -like "*- Latin*") { 
			$TTSVoice.Voice = $Voice
			[void]$TTSVoice.Speak($text)
			exit 0 # success
		}
	}
	throw "No Latin text-to-speech voice found - please install one"
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
