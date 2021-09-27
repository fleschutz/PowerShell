<#
.SYNOPSIS
	speak-text.ps1 [<text>]
.DESCRIPTION
	Speaks the given text by the default text-to-speech (TTS) voice
.EXAMPLE
	PS> ./speak-text "Hello World"
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

param([string]$text = "")

try {
	if ($text -eq "") { $text = read-host "Enter the text to speak" }

	$Voice = new-object -ComObject SAPI.SPVoice
	[void]$Voice.Speak($text)
	exit 0 # success
} catch {
	"⚠️ Error: $($Error[0]) ($($MyInvocation.MyCommand.Name):$($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
