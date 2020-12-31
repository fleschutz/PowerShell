#!/snap/bin/powershell
<#
.SYNTAX         ./speak-test.ps1
.DESCRIPTION	performs a test speak by text-to-speech (TTS)
.LINK		https://github.com/fleschutz/PowerShell
.NOTES		Author:	Markus Fleschutz / License: CC0
#>

try {
	$Voice = new-object -ComObject SAPI.SPVoice
	$Voice.Speak("This is the default voice")
	$Voice.Speak("Let's also try the other voices")

	$Voices = $Voice.GetVoices()
	foreach ($OtherVoice in $Voices) {
		$OtherVoice.GetDescription()
		$Voice.Voice = $OtherVoice
		$Voice.Speak("1 2 3 - this is a test")
	}
	exit 0
} catch {
	write-error "ERROR in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
