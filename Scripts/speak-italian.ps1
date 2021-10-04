<#
.SYNOPSIS
	Speaks the given text with an Italian text-to-speech (TTS) voice
.DESCRIPTION
	speak-italian.ps1 [<text>]
.EXAMPLE
	PS> ./speak-italian Ciao
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

param([string]$text = "")

try {
	if ($text -eq "") { $text = read-host "Enter the Italian text to speak" }

	$CurrentVoice = New-Object -ComObject SAPI.SPVoice
	$Voices = $CurrentVoice.GetVoices()
	foreach ($Voice in $Voices) {
		if ($Voice.GetDescription() -notlike "*- Italian*") { continue }
		$CurrentVoice.Voice = $Voice
		[void]$CurrentVoice.Speak($text)
		exit 0 # success
	}
	throw "No Italian text-to-speech voice found - please install one"
} catch {
	"⚠️ Error: $($Error[0]) ($($MyInvocation.MyCommand.Name):$($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
