<#
.SYNOPSIS
	translate-files.ps1 [<file-pattern>]
.DESCRIPTION
	Translates the given text files into any supported language.
.EXAMPLE
	PS> .\translate-files.ps1 C:\Temp\*.txt
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

param([string]$FilePattern = "")

function DetectSourceLang { param([string]$Filename)
	if ("$Filename" -like "*Deutsch*") { return "de" }
	if ("$Filename" -like "*English*") { return "en" }
	if ("$Filename" -like "*Français*") { return "fr" }
	return "unknown"
}

function TranslateFilename { param([string]$Filename, [string]$SourceLang, [string]$TargetLang)
	if ($SourceLang -eq "de") { $SourceLanguage = "Deutsch" }
	if ($SourceLang -eq "en") { $SourceLanguage = "English" }
	if ($SourceLang -eq "fr") { $SourceLanguage = "Français" }
	$TargetLanguage = ("$PSScriptRoot/translate-text.ps1" $SourceLanguage $SourceLang $TargetLang)
	return $Filename.replace($SourceLanguage, $TargetLanguage)
}

try {
	if ($FilePattern -eq "" ) { $FilePattern = read-host "Enter the file pattern" }

	$TargetLanguages = "ar","zh","fr","de","hi","ga","it","ja","ko","pt","ru","es"
	$SourceFiles = get-childItem -path "$FilePattern"
	foreach($SourceFile in $SourceFiles) {
		$SourceLang = DetectSourceLang $SourceFile
		foreach($TargetLang in $TargetLanguages) {
			if ($SourceLang -eq $TargetLang) { continue }
			$TargetFile = TranslateFilename $SourceFile $SourceLang $TargetLang
			& "$PSScriptRoot/translate-file.ps1" $SourceFile $SourceLang $TargetLang > $TargetFile
		}
	}
	exit 0
} catch {
	write-error "⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
