<#
.SYNOPSIS
	List installed text-to-speech voices
.DESCRIPTION
	This PowerShell script queries the installed text-to-speech (TTS) voices and prints them to the console.
.EXAMPLE
	PS> ./list-voices.ps1

	Name                     Culture  Gender     Age
	----                     -------  ------     ---
	Microsoft David Desktop  en-US      Male   Adult
	...
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

#requires -version 5.1

try {
	Add-Type -AssemblyName System.Speech
	$synth = New-Object System.Speech.Synthesis.SpeechSynthesizer
	$synth.GetInstalledVoices() | 
		Select-Object -ExpandProperty VoiceInfo | 
		Select-Object -Property Name, Culture, Gender, Age
	exit 0 # success
} catch {
	"⚠️ ERROR: $($Error[0]) (script line $($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
