<#
.SYNOPSIS
	Performs a text-to-speech test
.DESCRIPTION
	This PowerShell script performs a text-to-speech (TTS) test.
.EXAMPLE
	PS> ./speak-test.ps1
	📣 Let's begin with the default speed rate of 0 at the default volume of 100%.
	...
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

#requires -version 5.1

function Speak([string]$Text) { 
	Write-Output "📣 $Text"
	[void]$Voice.speak("$Text")
}

try {
	$Voice = New-Object -ComObject SAPI.SPVoice
	$DefaultVolume = $Voice.volume
	$DefaultRate = $Voice.rate
	Speak("Let's begin with the default speed rate of $DefaultRate at the default volume of $($DefaultVolume)%.")

	$Voice.rate = -10
	Speak("I'm speaking very, very slow at speed rate -10.")
	$Voice.rate = -5
	Speak("I'm speaking very slow at speed rate -5.")
	$Voice.rate = -3
	Speak("I'm speaking slow at rate -3.")
	$Voice.rate = 0
	Speak("I'm speaking quite normal at speed rate 0.")
	$Voice.rate = 2
	Speak("I'm speaking fast at speed rate 2.")
	$Voice.rate = 5
	Speak("I'm speaking very fast at speed rate 5.")
	$Voice.rate = 10
	Speak("I'm speaking very, very fast at speed rate 10.")
	$Voice.rate = $DefaultRate

	$Voice.volume = 100
	Speak("Let's try 100% volume.")
	$Voice.volume = 75
	Speak("Let's try 75% volume.")
	$Voice.volume = 50
	Speak("Let's try 50% volume.")
	$Voice.volume = 25
	Speak("Let's try 25% volume.")
	$Voice.volume = $DefaultVolume

	$Voices = $Voice.GetVoices()
	foreach ($OtherVoice in $Voices) {
		$Voice.Voice = $OtherVoice
		$Description = $OtherVoice.GetDescription()
		Speak("Hi, I'm the voice called $Description.")
	}
	Speak("Thanks for your attention.")
	exit 0 # success
} catch {
	"⚠️ ERROR: $($Error[0]) (script line $($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
