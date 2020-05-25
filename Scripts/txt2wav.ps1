#!/snap/bin/powershell
#
# PowerShell Script to Convert Text to Audio WAV files
# ----------------------------------------------------
# Author:  Markus Fleschutz
# Source:  github.com/fleschutz/PowerShell
# License: CC0

# Configuration:
$Text = "Hello, my name ist Bond, James Bond"
$Speed = -1 # -10 is slowest, 10 is fastest
$TargetWavFile = "spoken.wav"

# Run:
Add-Type -AssemblyName System.Speech
$SpeechSynthesizer = New-Object System.Speech.Synthesis.SpeechSynthesizer
# $SpeechSynthesizer.SelectVoice("Microsoft Eva Mobile")
$SpeechSynthesizer.Rate = $Speed
$SpeechSynthesizer.SetOutputToWaveFile($TargetWavFile)
$SpeechSynthesizer.Speak($Text)
$SpeechSynthesizer.Dispose()
exit 0
