<#
.SYNOPSIS
	Speaks text in Esperanto
.DESCRIPTION
	This PowerShell script speaks the given text with an Esperanto text-to-speech (TTS) voice.
.PARAMETER text
	Specifies the Esperanto text to speak
.EXAMPLE
	PS> ./speak-esperanto.ps1 Saluton
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

param([string]$text = "")

try {
	if ($text -eq "") { $text = Read-Host "Enter the Esperanto text to speak" }

	$TTS = New-Object -ComObject SAPI.SPVoice
	foreach ($voice in $TTS.GetVoices()) {
		if ($voice.GetDescription() -like "*- Esperanto*") {
			$TTS.Voice = $voice
			[void]$TTS.Speak($text)
			exit 0 # success
		}
	}
	throw "No Esperanto text-to-speech voice found - please install one."
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
