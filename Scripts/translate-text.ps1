<#
.SYNOPSIS
	Translates text into other languages
.DESCRIPTION
	This script translates text into other languages.
.PARAMETER Text
	Specifies the text to translate
.PARAMETER SourceLang
	Specifies the source language
.PARAMETER TargetLang
	Specifies the target language
.EXAMPLE
	PS> ./translate-text "Hello World" de en
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

param([string]$Text = "", [string]$SourceLang = "en", [string]$TargetLang = "any")

function Language2Code { param([string]$Language)
	$Code = switch($Language) {
	"Arabic"  {"ar"}
	"Chinese" {"zh"}
	"French"  {"fr"}
	"German"  {"de"}
	"Hindi"   {"hi"}
	"Irish"   {"ga"}
	"Italian" {"it"}
	"Japanese"{"ja"}
	"Korean"  {"ko"}
	"Portuguese"{"pt"}
	"Russian" {"ru"}
	"Spanish" {"es"}
	Default   {$Language}
	}
	return $Code
}

function UseGoogleTranslate { param([string]$Text, [string]$SourceLang, [string]$TargetLang)
	$Result = Invoke-RestMethod "https://translate.googleapis.com/translate_a/single?client=gtx&sl=$($SourceLang)&tl=$($TargetLang)&dt=t&q=$($Text)"
	return $Result[0][0][0]
}

function UseLibreTranslate { param([string]$Text, [string]$SourceLang, [string]$TargetLang)
	$Parameters = @{"q"="$Text"; "source"="$SourceLang"; "target"="$TargetLang"; }
	$Result = (Invoke-WebRequest -Uri https://libretranslate.com/translate -Method POST -Body ($Parameters|ConvertTo-Json) -ContentType "application/json").content | ConvertFrom-Json
	return $Result.translatedText
}

function UseArgosTranslateCLI { param([string]$Text, [string]$SourceLang, [string]$TargetLang)
	$Result = (argos-translate.cli --from-lang $SourceLang --to-lang $TargetLang $Text)
	return $Result
}

try {
	if ($Text -eq "" ) { $Text = read-host "Enter text in English to translate" }

	if ($TargetLang -eq "any") {
		$TargetLanguages = "Arabic","Chinese","French","German","Hindi","Irish","Italian","Japanese","Korean","Portuguese","Russian","Spanish"
		foreach($TargetLang in $TargetLanguages) {
			$TargetLangCode = Language2Code $TargetLang
			$Result = UseLibreTranslate $Text $SourceLang $TargetLangCode
			write-output "$TargetLang : $Result"
		}
	} else {
		$TargetLangCode = Language2Code $TargetLang
		$Result = UseLibreTranslate $Text $SourceLang $TargetLangCode
		write-output "$Result"
	}
	exit 0 # success
} catch {
	"⚠️ Error: $($Error[0]) ($($MyInvocation.MyCommand.Name):$($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
