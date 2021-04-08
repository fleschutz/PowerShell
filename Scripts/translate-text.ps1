#!/usr/bin/pwsh
<#
.SYNTAX       translate-text.ps1 [<text>] [<source-lang>]
.DESCRIPTION  translates the given text in English into other languages
.LINK         https://github.com/fleschutz/PowerShell
.NOTES        Author: Markus Fleschutz / License: CC0
#>

param($Text = "", $SourceLang = "en")

if ($Text -eq "" ) { $Text = read-host "Enter text in English to translate" }
$TargetLanguages = "af","da","de","el","es","fr","hr","it","ja","ko","pl","pt","nl","ru","tr","uk","vi"

function TranslateUsingGoogle { param([string]$Text, [string]$SourceLang, [string]$TargetLang)

	$URL = "https://translate.googleapis.com/translate_a/single?client=gtx&sl=$($SourceLang)&tl=$($TargetLang)&dt=t&q=$($Text)"
	$result = Invoke-RestMethod $URL
	return $result[0][0][0]
}

try {
	foreach($TargetLang in $TargetLanguages) {
		$Result = TranslateUsingGoogle $Text $SourceLang $TargetLang
		write-output "$TargetLang : $Result"
	}
	exit 0
} catch {
	write-error "ERROR: line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
