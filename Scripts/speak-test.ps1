#!/snap/bin/powershell
<#
.SYNTAX         ./speak-test.ps1
.DESCRIPTION	performs a test speak by text-to-speech (TTS)
.LINK		https://github.com/fleschutz/PowerShell
.NOTES		Author:	Markus Fleschutz / License: CC0
#>

try {
	$Voice = new-object -ComObject SAPI.SPVoice
	$DefaultVolume = $Voice.volume
	$DefaultRate = $Voice.rate
	$Result = $Voice.Speak("This is the default voice with default volume $DefaultVolume and speed $DefaultRate")

	$Voice.rate = -10
	$Result = $Voice.Speak("Let's speak very, very slow")
	$Voice.rate = -5
	$Result = $Voice.Speak("Let's speak very slow")
	$Voice.rate = 2
	$Result = $Voice.Speak("Let's speak fast")
	$Voice.rate = 5
	$Result = $Voice.Speak("Let's speak very fast")
	$Voice.rate = 10
	$Result = $Voice.Speak("Let's speak very, very fast")
	$Voice.rate = $DefaultRate

	$Voice.volume = 100
	$Result = $Voice.Speak("Let's try 100% volume")
	$Voice.volume = 75
	$Result = $Voice.Speak("Let's try 75% volume")
	$Voice.volume = 50
	$Result = $Voice.Speak("Let's try 50% volume")
	$Voice.volume = 25
	$Result = $Voice.Speak("Let's try 25% volume")
	$Voice.volume = $DefaultVolume

	$Voices = $Voice.GetVoices()
	foreach ($OtherVoice in $Voices) {
		$Description = $OtherVoice.GetDescription()
		write-output "Voice: $Description"
		$Voice.Voice = $OtherVoice
		$Result = $Voice.Speak("Hello, I'm the voice called $Description")
	}
	exit 0
} catch {
	write-error "ERROR in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
