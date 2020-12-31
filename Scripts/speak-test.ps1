#!/snap/bin/powershell
<#
.SYNTAX         ./speak-test.ps1
.DESCRIPTION	performs a test speak by text-to-speech (TTS)
.LINK		https://github.com/fleschutz/PowerShell
.NOTES		Author:	Markus Fleschutz / License: CC0
#>

try {
	$Voice = new-object -ComObject SAPI.SPVoice
	$Result = $Voice.Speak("This is the default voice")

	$Voice.rate = 8
	$Result = $Voice.Speak("Let's speak very, very fast")
	$Voice.rate = -10
	$Result = $Voice.Speak("Let's speak very, very slow")
	$Voice.rate = 0

	$PrevVolume = $Voice.Volume
	$Voice.volume = 100
	$Result = $Voice.Speak("Let's speak with maximum volume")
	$Voice.volume = 50
	$Result = $Voice.Speak("Let's speak with half volume")
	$Voice.volume = $PrevVolume

	$Voices = $Voice.GetVoices()
	foreach ($OtherVoice in $Voices) {
		$Description = $OtherVoice.GetDescription()
		write-output "This is: $Description"
		$Voice.Voice = $OtherVoice
		$Result = $Voice.Speak("1 2 3 - this is $Description")
	}
	exit 0
} catch {
	write-error "ERROR in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
