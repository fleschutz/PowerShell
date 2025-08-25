<#
.SYNOPSIS
	Spells a word
.DESCRIPTION
	This PowerShell script spells the given word by text-to-speech (TTS).
.PARAMETER word
        Specifies the word to spell (queried by default)
.EXAMPLE
	PS> ./spell-word.ps1 Yoda
	(listen)
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

param([string]$word = "")

try {
	if ($word -eq "" ) { $word = Read-Host "Enter the word to spell" }

	[char[]]$array = $word.ToUpper()
	$reply = ""
	foreach($char in $array) {
		$reply += $char + ", "
	}
	& "$PSScriptRoot/speak-english.ps1" $reply
	exit 0 # success
} catch {
	"⚠️ ERROR: $($Error[0]) (script line $($_.InvocationInfo.ScriptLineNumber))"
        exit 1
}
