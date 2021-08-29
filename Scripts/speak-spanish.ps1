<#
.SYNOPSIS
	speak-spanish.ps1 [<text>]
.DESCRIPTION
	Speaks the given text with a Spanish text-to-speech (TTS) voice.
.EXAMPLE
	PS> .\speak-spanish.ps1 Hola
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

param([string]$Text = "")

try {
	if ($Text -eq "") { $Text = read-host "Enter the text to speak" }

	$Voice = new-object -ComObject SAPI.SPVoice
	$Voices = $Voice.GetVoices()
	foreach ($OtherVoice in $Voices) {
		$Description = $OtherVoice.GetDescription()
		if ($Description -notlike "*- Spanish*") { continue }
		$Voice.Voice = $OtherVoice
		[void]$Voice.Speak($Text)
		exit 0
	}
	write-error "No Spanish text-to-speech voice found - please install one"
	exit 1
} catch {
	write-error "⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
