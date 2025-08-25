<#
.SYNOPSIS
	Speaks text by the default text-to-speech voice
.DESCRIPTION
	This PowerShell script speaks the given text by the default text-to-speech (TTS) voice.
.PARAMETER text
	Specifies the text to read
.EXAMPLE
	PS> ./speak-text.ps1 Hi
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

#requires -version 5.1

param([string]$text = "")

try {
	if ($text -eq "") { $text = Read-Host "Enter the text to speak" }

	$Voice = new-object -ComObject SAPI.SPVoice
	[void]$Voice.Speak($text)
	exit 0 # success
} catch {
	"⚠️ ERROR: $($Error[0]) (script line $($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
