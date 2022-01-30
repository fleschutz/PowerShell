<#
.SYNOPSIS
	Speaks text with a German text-to-speech voice
.DESCRIPTION
	This PowerShell script speaks the given text with a German text-to-speech (TTS) voice.
.PARAMETER text
	Specifies the text to speak
.EXAMPLE
	PS> ./speak-german Hallo
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz / License: CC0
#>

param([string]$text = "")

try {
	if ($text -eq "") { $text = read-host "Enter the German text to speak" }

	$TTSVoice = New-Object -ComObject SAPI.SPVoice
	foreach ($Voice in $TTSVoice.GetVoices()) {
		if ($Voice.GetDescription() -like "*- German*") { 
			$TTSVoice.Voice = $Voice
			[void]$TTSVoice.Speak($text)
			exit 0 # success
		}
	}
	throw "No German text-to-speech voice found - please install one"
} catch {
	"⚠️ Error: $($Error[0]) ($($MyInvocation.MyCommand.Name):$($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
