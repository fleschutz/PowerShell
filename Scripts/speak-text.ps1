<#
.SYNOPSIS
	speak-text.ps1 [<text>]
.DESCRIPTION
	Speaks the given text by text-to-speech (TTS)
.EXAMPLE
	PS> .\speak-text.ps1 "Hello World"
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author:  Markus Fleschutz
	License: CC0
#>

param([string]$Text = "")

try {
	if ($Text -eq "") { $Text = read-host "Enter the text to speak" }

	$Voice = new-object -ComObject SAPI.SPVoice
	$Result = $Voice.Speak($Text)
	exit 0
} catch {
	write-error "⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
