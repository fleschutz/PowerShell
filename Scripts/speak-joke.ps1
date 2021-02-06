#!/snap/bin/powershell
<#
.SYNTAX         ./speak-joke.ps1
.DESCRIPTION	speaks the next joke by text-to-speech (TTS)
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
	$PathToRepo = "$PSScriptRoot/.."

	$Table = import-csv "$PathToRepo/Data/jokes.csv"

	$Generator = New-Object System.Random
	$Index = [int]$Generator.next(0,66)

	$Joke = $Table[$Index].Joke

	[system.threading.thread]::currentthread.currentculture=[system.globalization.cultureinfo]"en-US"
	Speak $Joke
	exit 0
} catch {
	write-error "ERROR in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
