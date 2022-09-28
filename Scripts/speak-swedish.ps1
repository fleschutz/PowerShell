<#
.SYNOPSIS
	Speaks text in Swedish
.DESCRIPTION
	This PowerShell script speaks the given text with a Swedish text-to-speech (TTS) voice.
.PARAMETER text
	Specifies the text to speak
.EXAMPLE
	PS> ./speak-swedish Hallå
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

param([string]$text = "")

try {
	if ($text -eq "") { $text = read-host "Enter the Swedish text to speak" }

	$TTS = New-Object -ComObject SAPI.SPVoice
	foreach ($Voice in $TTS.GetVoices()) {
		if ($Voice.GetDescription() -like "*- Swedish*") { 
			$TTS.Voice = $Voice
			[void]$TTS.Speak($text)
			exit 0 # success
		}
	}
	throw "No Swedish voice for text-to-speech (TTS) found - please install one"
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
