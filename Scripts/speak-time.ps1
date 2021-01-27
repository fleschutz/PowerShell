#!/snap/bin/powershell
<#
.SYNTAX         ./speak-time.ps1
.DESCRIPTION	speaks the current time by text-to-speech (TTS)
.LINK		https://github.com/fleschutz/PowerShell
.NOTES		Author:	Markus Fleschutz / License: CC0
#>

function Speak { param([string]$Text)
	write-progress "$Text"
	$Voice = new-object -ComObject SAPI.SPVoice
	$Voices = $Voice.GetVoices()
	foreach ($OtherVoice in $Voices) {
		$Description = $OtherVoice.GetDescription()
		if ($Description -like "*- English (United States)") {
			$Voice.Voice = $OtherVoice
			break
		}
	}
	[void]$Voice.Speak($Text)
	write-progress -complete "$Text"
}

try {
	[system.threading.thread]::currentthread.currentculture=[system.globalization.cultureinfo]"en-US"
	Speak("It's now $((Get-Date).ToShortTimeString())")
	exit 0
} catch {
	write-error "ERROR in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
