<#
.SYNOPSIS
	Translates a text file into another language 
.DESCRIPTION
	This PowerShell script translates the given text file into another language and writes the output on the console.
.PARAMETER File
	Specifies the path to the file to be translated
.PARAMETER SourceLang
	Specifies the source language
.PARAMETER TargetLang
	Specifies the target language
.EXAMPLE
	PS> ./translate-file C:\Memo.txt en de
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

param([string]$File = "", [string]$SourceLang = "", [string]$TargetLang = "")

function UseLibreTranslate { param([string]$Text, [string]$SourceLang, [string]$TargetLang)
	$Parameters = @{"q"="$Text"; "source"="$SourceLang"; "target"="$TargetLang"; }
	$Result = (Invoke-WebRequest -Uri https://libretranslate.de/translate -Method POST -Body ($Parameters|ConvertTo-Json) -ContentType "application/json" -useBasicParsing).content | ConvertFrom-Json
	Start-Sleep -seconds 6 # 10 requests per minute maximum
	return $Result.translatedText
}

try {
	if ($File -eq "" ) { $File = Read-Host "Enter the file path" }
	if ($SourceLang -eq "" ) { $SourceLang = Read-Host "Enter the source language" }
	if ($TargetLang -eq "" ) { $TargetLang = Read-Host "Enter the target language" }

	$Lines = Get-Content -path $File
	foreach($Line in $Lines) {
		if ("$Line" -eq "") { Write-Output "$Line"; continue }
		if ("$Line" -eq " ") { Write-Output "$Line"; continue }
		if ("$Line" -like "===*") { Write-Output "$Line"; continue }
		if ("$Line" -like "---*") { Write-Output "$Line"; continue }
		if ("$Line" -like "!*(/*)") { Write-Output "$Line"; continue }
		$Result = UseLibreTranslate $Line $SourceLang $TargetLang
		Write-Output $Result
	}
	exit 0 # success
} catch {
	"⚠️ ERROR: $($Error[0]) (script line $($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
