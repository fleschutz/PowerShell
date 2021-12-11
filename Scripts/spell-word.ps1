<#
.SYNOPSIS
	Spells a word
.DESCRIPTION
	This script spells the given word by text-to-speech (TTS).
.PARAMETER word
        Specifies the word to spell
.EXAMPLE
	PS> ./spell-word
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

param([string]$word = "")

try {
	if ($word -eq "" ) { $word = read-host "Enter word to spell" }

	[char[]]$ArrayOfChars = $word.ToUpper()
	$Reply = ""
	foreach($Char in $ArrayOfChars) {
		$Reply += $Char
		$Reply += " "
	}
	& "$PSScriptRoot/give-reply.ps1" "$Reply"
	exit 0 # success
} catch {
        "⚠️Error: $($Error[0]) ($($MyInvocation.MyCommand.Name):$($_.InvocationInfo.ScriptLineNumber))"
        exit 1
}