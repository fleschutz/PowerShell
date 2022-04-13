<#
.SYNOPSIS
	Speaks text by the default text-to-speech voice
.DESCRIPTION
	This PowerShell script speaks the given text by the default text-to-speech (TTS) voice.
.PARAMETER text
	Specifies the text to read
.EXAMPLE
	PS> ./speak-text "Hello World"
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz / License: CC0
#>

param([string]$text = "")

try {
	if ($text -eq "") { $text = read-host "Enter the text to speak" }

	$Voice = new-object -ComObject SAPI.SPVoice
	[void]$Voice.Speak($text)
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
