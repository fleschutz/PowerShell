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

#Requires -Version 2.0

try {
	Add-Type -AssemblyName System.Speech
	$Synth = New-Object System.Speech.Synthesis.SpeechSynthesizer
	$Synth.GetInstalledVoices() | 
		Select-Object -ExpandProperty VoiceInfo | 
		Select-Object -Property Name, Culture, Gender, Age
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
