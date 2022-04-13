<#
.SYNOPSIS
	Converts text to a .WAV audio file
.DESCRIPTION
	This PowerShell script converts text to a .WAV audio file.
.PARAMETER text
	Specifies the text to use
.PARAMETER WavFile
	Specifies the path to the resulting WAV file
.EXAMPLE
	PS> ./convert-txt2wav "Hello World" spoken.wav
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz / License: CC0
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
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
