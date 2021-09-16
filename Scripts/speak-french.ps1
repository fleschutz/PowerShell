<#
.SYNOPSIS
	speak-french.ps1 [<text>]
.DESCRIPTION
	Speaks the given text with a French text-to-speech (TTS) voice.
.EXAMPLE
	PS> .\speak-french.ps1 Salut
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

param([string]$text = "")

try {
	if ($text -eq "") { $text = read-host "Enter the French text to speak" }

	$Voice = New-Object -ComObject SAPI.SPVoice
	$Voices = $Voice.GetVoices()
	foreach ($OtherVoice in $Voices) {
		$Description = $OtherVoice.GetDescription()
		if ($Description -notlike "*- French*") { continue }
		$Voice.Voice = $OtherVoice
		[void]$Voice.Speak($text)
		exit 0
	}
	write-error "Sorry, no French text-to-speech voice found - please install one"
	exit 1
} catch {
	write-error "⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
