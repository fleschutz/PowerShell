#Requires -Version 2.0
<#
.SYNOPSIS
	list-voices.ps1 
.DESCRIPTION
	Lists the installed text-to-speech (TTS) voices.
.EXAMPLE
	PS> .\list-voices.ps1
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

try {
	add-type -AssemblyName System.Speech
	$speak = New-Object System.Speech.Synthesis.SpeechSynthesizer
	$speak.GetInstalledVoices() | 
	  Select-Object -ExpandProperty VoiceInfo | 
	  Select-Object -Property Name, Culture, Gender, Age

	exit 0
} catch {
	write-error "⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
