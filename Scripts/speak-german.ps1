<#
.SYNOPSIS
	speak-german.ps1 [<text>]
.DESCRIPTION
	Speaks the given text with a German text-to-speech (TTS) voice.
.EXAMPLE
	PS> .\speak-german.ps1 Hallo
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

param([string]$text = "")

try {
	if ($text -eq "") { $text = read-host "Enter the German text to speak" }

	$Voice = New-Object -ComObject SAPI.SPVoice
	$Voices = $Voice.GetVoices()
	foreach ($OtherVoice in $Voices) {
		$Description = $OtherVoice.GetDescription()
		if ($Description -notlike "*- German*") { continue }
		$Voice.Voice = $OtherVoice
		[void]$Voice.Speak($text)
		exit 0
	}
	throw "No German text-to-speech voice found - please install one"
} catch {
	"⚠️ Error: $($Error[0]) ($($MyInvocation.MyCommand.Name):$($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
