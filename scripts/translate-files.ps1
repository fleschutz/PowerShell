<#
.SYNOPSIS
	Translates text files
.DESCRIPTION
	This PowerShell script translates text files into multiple languages.
.PARAMETER filePattern
	Specifies the file pattern of the text file(s) to be translated
.EXAMPLE
	PS> ./translate-files C:\Temp\*.txt
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

param([string]$filePattern = "")

function DetectSourceLang { param([string]$Filename)
	if ("$Filename" -like "*-Deutsch*")  { return "de" }
	if ("$Filename" -like "*-English*")  { return "en" }
	if ("$Filename" -like "*-Español*")  { return "es" }
	if ("$Filename" -like "*-Français*") { return "fr" }
	if ("$Filename" -like "*-Portuguese*") { return "pt" }
	return "unknown"
}

function TranslateFilename { param([string]$Filename, [string]$SourceLang, [string]$TargetLang)
	[string]$SourceLanguage = ""
	if ($SourceLang -eq "de") { $SourceLanguage = "-Deutsch" }
	if ($SourceLang -eq "en") { $SourceLanguage = "-English" }
	if ($SourceLang -eq "es") { $SourceLanguage = "-Español" }
	if ($SourceLang -eq "fr") { $SourceLanguage = "-Français" }
	if ($SourceLang -eq "pt") { $SourceLanguage = "-Portuguese" }
	[string]$TargetLanguage = "-Unknown"
	if ($TargetLang -eq "ar") { $TargetLanguage = "-Arabic" }
	if ($TargetLang -eq "de") { $TargetLanguage = "-Deutsch" }
	if ($TargetLang -eq "en") { $TargetLanguage = "-English" }
	if ($TargetLang -eq "es") { $TargetLanguage = "-Español" }
	if ($TargetLang -eq "fr") { $TargetLanguage = "-Français" }
	if ($TargetLang -eq "pt") { $TargetLanguage = "-Portuguese" }
	return $Filename.replace($SourceLanguage, $TargetLanguage)
}

try {
	if ($filePattern -eq "" ) { $filePattern = Read-Host "Enter the file pattern of the text file(s) to be translated" }

	$TargetLanguages = "ar","zh","fr","de","hi","ga","it","ja","ko","pt","ru","es"
	$SourceFiles = Get-ChildItem -path "$filePattern"
	foreach($SourceFile in $SourceFiles) {
		$SourceLang = DetectSourceLang $SourceFile
		foreach($TargetLang in $TargetLanguages) {
			if ($SourceLang -eq $TargetLang) { continue }
			Write-Host "Translating $SourceFile from $SourceLang to $TargetLang ..."
			$TargetFile = TranslateFilename $SourceFile $SourceLang $TargetLang
			Write-Host "$TargetFile"
			& "$PSScriptRoot/translate-file.ps1" $SourceFile $SourceLang $TargetLang > $TargetFile
		}
	}
	exit 0 # success
} catch {
	"⚠️ ERROR: $($Error[0]) (script line $($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
