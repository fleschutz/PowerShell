<#
.SYNOPSIS
	Gives a reply 
.DESCRIPTION
	This script gives a reply in English by text-to-speech (TTS).
.PARAMETER text
	Specifies the text to speak
.EXAMPLE
	PS> ./give-reply "Hello World"
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

param([string]$text = "")

try {
	"📣$text"

	$TTSVoice = New-Object -ComObject SAPI.SPVoice
	foreach ($Voice in $TTSVoice.GetVoices()) {
		if ($Voice.GetDescription() -like "*- English*") {
			$TTSVoice.Voice = $Voice
			[void]$TTSVoice.Speak($text)
			exit 0 # success
		}
	}
	exit 0 # success
} catch {
	"⚠️ Error: $($Error[0]) ($($MyInvocation.MyCommand.Name):$($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
