<#
.SYNOPSIS
	Speaks text in Dutch
.DESCRIPTION
	This PowerShell script speaks the given text with a Dutch text-to-speech (TTS) voice.
.PARAMETER text
	Specifies the Dutch text to speak
.EXAMPLE
	PS> ./speak-dutch.ps1 Hallo
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

param([string]$text = "")

try {
	if ($text -eq "") { $text = Read-Host "Enter the Dutch text to speak" }

	$TTS = New-Object -ComObject SAPI.SPVoice
	foreach ($voice in $TTS.GetVoices()) {
		if ($voice.GetDescription() -like "*- Dutch*") { 
			$TTS.Voice = $voice
			[void]$TTS.Speak($text)
			exit 0 # success
		}
	}
	throw "No Dutch text-to-speech voice found - please install one"
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
