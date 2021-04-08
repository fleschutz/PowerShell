#!/bin/powershell
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

try {
	$PathToRepo = "$PSScriptRoot/.."

	$Engine = "google" # aspell | google | bing | spell | hunspell | apertium | yandex

	start-process -filePath "$PathToRepo/Data/trans" -argumentList "-i $File -s $SourceLang -t $TargetLang -e $Engine -brief" -noNewWindow -wait

	exit 0
} catch {
	write-error "ERROR: line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
