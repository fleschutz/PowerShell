#!/usr/bin/pwsh
<#
.SYNTAX       translate-text.ps1 [<text>] [<source-lang>]
.DESCRIPTION  translates the given text in English into other languages
.LINK         https://github.com/fleschutz/PowerShell
.NOTES        Author: Markus Fleschutz / License: CC0
#>

param($Text = "", $SourceLang = "en")

if ($Text -eq "" ) { $Text = read-host "Enter text in English to translate" }
$TargetLanguages = "Arabic","Chinese","French","German","Hindi","Irish","Italian","Japanese","Korean","Portuguese","Russian","Spanish"

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
	foreach($TargetLanguage in $TargetLanguages) {
		$TargetLangCode = Language2Code $TargetLanguage
		$Result = UseLibreTranslate $Text $SourceLang $TargetLangCode
		write-output "$TargetLanguage : $Result"
	}
	exit 0
} catch {
	write-error "ERROR: line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
