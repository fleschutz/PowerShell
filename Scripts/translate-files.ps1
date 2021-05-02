<#
.SYNTAX         ./translate-files.ps1 [<file-pattern>]
.DESCRIPTION	translates the given text files into any supported language
.LINK		https://github.com/fleschutz/PowerShell
.NOTES		Author:	Markus Fleschutz / License: CC0
#>

param($FilePattern = "")
if ($FilePattern -eq "" ) { $FilePattern = read-host "Enter the file pattern" }

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
