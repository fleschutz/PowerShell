<#
.SYNOPSIS
	Speaks text with a Greek text-to-speech voice
.DESCRIPTION
	This PowerShell script speaks the given text with a Greek text-to-speech (TTS) voice.
.PARAMETER text
	Specifies the text to speak
.EXAMPLE
	PS> ./speak-greek "γεια"
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

param([string]$text = "")

try {
	if ($text -eq "") { $text = read-host "Enter the Greek text to speak" }

	$TTS = New-Object -ComObject SAPI.SPVoice
	foreach ($Voice in $TTS.GetVoices()) {
		if ($Voice.GetDescription() -like "*- Greek*") { 
			$TTS.Voice = $Voice
			[void]$TTS.Speak($text)
			exit 0 # success
		}
	}
	throw "No Greek voice for text-to-speech (TTS) found - please install one"
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
