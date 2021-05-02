<#
.SYNTAX         ./translate-file.ps1 [<file>] [<source-lang>] [<target-lang>]
.DESCRIPTION	translates the given text file into another language and prints the result.
.LINK		https://github.com/fleschutz/PowerShell
.NOTES		Author:	Markus Fleschutz / License: CC0
#>

param($File = "", $SourceLang = "", $TargetLang = "")

if ($File -eq "" ) { $File = read-host "Enter path to file" }
if ($SourceLang -eq "" ) { $SourceLang = read-host "Enter language used in this file" }
if ($TargetLang -eq "" ) { $TargetLang = read-host "Enter language to translate to" }

function UseLibreTranslate { param([string]$Text, [string]$SourceLang, [string]$TargetLang)
	$Parameters = @{"q"="$Text"; "source"="$SourceLang"; "target"="$TargetLang"; }
	$Result = (Invoke-WebRequest -Uri https://libretranslate.com/translate -Method POST -Body ($Parameters|ConvertTo-Json) -ContentType "application/json").content | ConvertFrom-Json
	start-sleep -milliseconds 3000 # 20 requests per minute maximum
	return $Result.translatedText
}

try {
	$Lines = Get-Content -path $File
	foreach($Line in $Lines) {
		if ("$Line" -eq "") { write-output "$Line"; continue }
		if ("$Line" -eq " ") { write-output "$Line"; continue }
		if ("$Line" -like "===*") { write-output "$Line"; continue }
		if ("$Line" -like "---*") { write-output "$Line"; continue }
		if ("$Line" -like "!*(/*)") { write-output "$Line"; continue }
		$Result = UseLibreTranslate $Line $SourceLang $TargetLang
		write-output $Result
	}
	exit 0
} catch {
	write-error "⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
