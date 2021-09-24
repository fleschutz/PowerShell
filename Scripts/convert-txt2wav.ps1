<#
.SYNOPSIS
	convert-txt2wav.ps1 [<text>] [<wav-file>]
.DESCRIPTION
	Converts text to a .WAV audio file
.EXAMPLE
	PS> ./convert-txt2wav "Hello World" spoken.wav
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

param([string]$Text = "", [string]$WavFile = "")

try {
	if ($Text -eq "") { $Text = read-host "Enter text to speak" }
	if ($WavFile -eq "") { $WavFile = read-host "Enter .WAV file to save to" }

	Add-Type -AssemblyName System.Speech
	$SpeechSynthesizer = New-Object System.Speech.Synthesis.SpeechSynthesizer
	$SpeechSynthesizer.SetOutputToWaveFile($tWavFile)
	$SpeechSynthesizer.Speak($Text)
	$SpeechSynthesizer.Dispose()
	exit 0
} catch {
	"⚠️ Error: $($Error[0]) ($($MyInvocation.MyCommand.Name):$($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
