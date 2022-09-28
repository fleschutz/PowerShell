<#
.SYNOPSIS
	Speaks text in German 
.DESCRIPTION
	This PowerShell script speaks the given text with a German text-to-speech (TTS) voice.
.PARAMETER text
	Specifies the text to speak
.EXAMPLE
	PS> ./speak-german Hallo
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

param([string]$text = "")

try {
	if ($text -eq "") { $text = read-host "Enter the German text to speak" }

	$TTS = New-Object -ComObject SAPI.SPVoice
	foreach ($Voice in $TTS.GetVoices()) {
		if ($Voice.GetDescription() -like "*- German*") { 
			$TTS.Voice = $Voice
			[void]$TTS.Speak($text)
			exit 0 # success
		}
	}
	throw "No German voice for text-to-speech (TTS) found - please install one"
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
