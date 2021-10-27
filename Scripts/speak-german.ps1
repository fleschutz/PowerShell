<#
.SYNOPSIS
	Speaks text with a German text-to-speech voice
.DESCRIPTION
	This script speaks the given text with a German text-to-speech (TTS) voice.
	Requires that a German TTS voice is installed.
.PARAMETER text
	Specifies the text to speak
.EXAMPLE
	PS> ./speak-german Hallo
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

param([string]$text = "")

try {
	if ($text -eq "") { $text = read-host "Enter the German text to speak" }

	$CurrentVoice = New-Object -ComObject SAPI.SPVoice
	$Voices = $CurrentVoice.GetVoices()
	foreach ($Voice in $Voices) {
		if ($Voice.GetDescription() -notlike "*- German*") { continue }
		$CurrentVoice.Voice = $Voice
		[void]$CurrentVoice.Speak($text)
		exit 0 # success
	}
	throw "No German text-to-speech voice found - please install one"
} catch {
	"⚠️ Error: $($Error[0]) ($($MyInvocation.MyCommand.Name):$($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
