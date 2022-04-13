<#
.SYNOPSIS
	Translates text into other languages
.DESCRIPTION
	This PowerShell script translates text into other languages.
.PARAMETER Text
	Specifies the text to translate
.PARAMETER SourceLang
	Specifies the source language
.PARAMETER TargetLang
	Specifies the target language
.EXAMPLE
	PS> ./translate-text "Hello World" de en
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz / License: CC0
#>

param([string]$Text = "", [string]$SourceLangCode = "en", [string]$TargetLangCode = "any")

function UseLibreTranslate { param([string]$Text, [string]$SourceLangCode, [string]$TargetLangCode)
	$Parameters = @{"q"="$Text"; "source"="$SourceLangCode"; "target"="$TargetLangCode"; }
	$Result = (Invoke-WebRequest -Uri https://translate.mentality.rip/translate -Method POST -Body ($Parameters|ConvertTo-Json) -ContentType "application/json" -useBasicParsing).content | ConvertFrom-Json
	return $Result.translatedText
}

try {
	if ($Text -eq "" ) { $Text = read-host "Enter text to translate" }

	if ($TargetLangCode -eq "any") {
		$TargetLangCodes = "ar","de","es","fr","ga","hi","it","ja","ko","pt","ru","zh"
		foreach($TargetLangCode in $TargetLangCodes) {
			$Translation = UseLibreTranslate $Text $SourceLangCode $TargetLangCode
			write-output "$($TargetLangCode): $Translation"
		}
	} else {
		$Translation = UseLibreTranslate $Text $SourceLangCode $TargetLangCode
		write-output "$Translation"
	}
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
