<#
.SYNOPSIS
	Translates text into other languages
.DESCRIPTION
	This PowerShell script translates text into other languages.
.PARAMETER Text
	Specifies the text to translate
.PARAMETER SourceLang
	Specifies the source language (English by default)
.PARAMETER TargetLang
	Specifies the target language (all by default)
.EXAMPLE
	PS> ./translate-text "Hello World" en all
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

param([string]$Text = "", [string]$SourceLangCode = "en", [string]$TargetLangCode = "all")

function UseLibreTranslate { param([string]$Text, [string]$SourceLangCode, [string]$TargetLangCode)
	$Parameters = @{"q"="$Text"; "source"="$SourceLangCode"; "target"="$TargetLangCode"; }
	$Result = (Invoke-WebRequest -Uri https://libretranslate.de/translate -Method POST -Body ($Parameters|ConvertTo-Json) -ContentType "application/json" -useBasicParsing).content | ConvertFrom-Json
	return $Result.translatedText
}

try {
	if ($Text -eq "" ) { $Text = Read-Host "Enter the text to translate" }

	if ($TargetLangCode -eq "all") {
		$TargetLangCodes = "ar","de","es","fr","ga","hi","it","ja","ko","pt","ru","zh"
		foreach($TargetLangCode in $TargetLangCodes) {
			$Translation = UseLibreTranslate $Text $SourceLangCode $TargetLangCode
			Write-Output "$($TargetLangCode): $Translation"
			Start-Sleep -seconds 6 # 10 requests maximum per minute
		}
	} else {
		$Translation = UseLibreTranslate $Text $SourceLangCode $TargetLangCode
		Write-Output "$Translation"
	}
	exit 0 # success
} catch {
	"⚠️ ERROR: $($Error[0]) (script line $($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
