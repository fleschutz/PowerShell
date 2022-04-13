<#
.SYNOPSIS
	Gives a reply 
.DESCRIPTION
	This PowerShell script gives a reply in English on the console and by text-to-speech (TTS).
.PARAMETER text
	Specifies the text to speak
.EXAMPLE
	PS> ./give-reply "Hello World"
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz / License: CC0
#>

param([string]$text = "")

function GetTempDir {
	if ("$env:TEMP" -ne "")	{ return "$env:TEMP" }
	if ("$env:TMP" -ne "")	{ return "$env:TMP" }
	if ($IsLinux) { return "/tmp" }
	return "C:\Temp"
}

try {
	# print reply on the console:
	" ← $text"

	# speak by text-to-speech (TTS):
	if (!$IsLinux) {
		$TTSVoice = New-Object -ComObject SAPI.SPVoice
		foreach ($Voice in $TTSVoice.GetVoices()) {
			if ($Voice.GetDescription() -like "*- English*") { $TTSVoice.Voice = $Voice }
		}
		[void]$TTSVoice.Speak($text)
	}

	# remember last reply:
	"$text" > "$(GetTempDir)/last_reply_given.txt"
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
