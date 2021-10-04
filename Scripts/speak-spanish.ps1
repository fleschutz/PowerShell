<#
.SYNOPSIS
	Speaks the given text with a Spanish text-to-speech (TTS) voice
.DESCRIPTION
	speak-spanish.ps1 [<text>]
.EXAMPLE
	PS> ./speak-spanish Hola
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

param([string]$text = "")

try {
	if ($text -eq "") { $text = read-host "Enter the Spanish text to speak" }

	$CurrentVoice = New-Object -ComObject SAPI.SPVoice
	$Voices = $CurrentVoice.GetVoices()
	foreach ($Voice in $Voices) {
		if ($Voice.GetDescription() -notlike "*- Spanish*") { continue }
		$CurrentVoice.Voice = $Voice
		[void]$CurrentVoice.Speak($text)
		exit 0 # success
	}
	throw "No Spanish text-to-speech voice found - please install one"
} catch {
	"⚠️ Error: $($Error[0]) ($($MyInvocation.MyCommand.Name):$($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
