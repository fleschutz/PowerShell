#!/snap/bin/powershell
<#
.SYNTAX         ./txt2wav.ps1
.DESCRIPTION	converts the given text into an audio .WAV file
.LINK		https://github.com/fleschutz/PowerShell
.NOTES		Author:	Markus Fleschutz / License: CC0
#>

$Text = "Hello, my name ist Bond, James Bond"
$Speed = -1 # -10 is slowest, 10 is fastest
$TargetWavFile = "spoken.wav"

try {
	Add-Type -AssemblyName System.Speech
	$SpeechSynthesizer = New-Object System.Speech.Synthesis.SpeechSynthesizer
	# $SpeechSynthesizer.SelectVoice("Microsoft Eva Mobile")
	$SpeechSynthesizer.Rate = $Speed
	$SpeechSynthesizer.SetOutputToWaveFile($TargetWavFile)
	$SpeechSynthesizer.Speak($Text)
	$SpeechSynthesizer.Dispose()
	exit 0
} catch {
	write-error "ERROR in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
