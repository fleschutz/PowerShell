#!/usr/bin/pwsh
<#
.SYNTAX       translate-text.ps1 [<text>] [<source-lang>]
.DESCRIPTION  translates the given text into other languages
.LINK         https://github.com/fleschutz/PowerShell
.NOTES        Author: Markus Fleschutz / License: CC0
#>

param($SourceText = "", $SourceLang = "en")
if ($SourceText -eq "" ) { $SourceText = read-host "Enter text to translate" }
$TargetLanguages = "af","da","de","el","es","fr","hr","it","ja","ko","pl","pt","nl","ru","tr","uk","vi"

function TranslateWithGoogle {
	[CmdletBinding()]
	param (
	 	[Parameter(Position = 1, ValueFromPipeline = $true)]
	 	[ValidateNotNullorEmpty()]
	 	[string]$Text,

	 	[Parameter(Position = 2)]
	 	[ValidateNotNullorEmpty()]
	 	[string]$SourceLang,

	 	[Parameter(Position = 3)]
	 	[ValidateNotNullorEmpty()]
	 	[string]$TargetLang
	)

	$URL = "https://translate.googleapis.com/translate_a/single?client=gtx&sl=$($SourceLang)&tl=$($TargetLang)&dt=t&q=$($Text)"
	$result = Invoke-RestMethod $URL
	return $result[0][0][0]
}

try {
	foreach($TargetLanguage in $TargetLanguages) {
		$Result = TranslateWithGoogle $SourceText $SourceLang $TargetLanguage
		write-output $TargetLanguage" : "$Result
	}
	exit 0
} catch {
	write-error "ERROR: line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
