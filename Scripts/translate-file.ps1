#!/snap/bin/powershell

# Syntax:	./translate-file.ps1 [<file>]
# Description:	translates the given file from source to target language.
# Author:	Markus Fleschutz
# Source:	github.com/fleschutz/PowerShell
# License:	CC0

param([string]$SourceFile, [string]$SourceLanguage, [string]$TargetLanguage)
if ($SourceFile -eq "" ) {
	$SourceFile = read-host "Enter path to file"
}
if ($SourceLanguage -eq "" ) {
	$SourceLanguage = read-host "Enter source language"
}
if ($TargetLanguage -eq "" ) {
	$TargetLanguage = read-host "Enter target language"
}

try {
	$ScriptPath=$MyInvocation.MyCommand.Path
	$ScriptPath/trans -i $SourceFile -s $SourceLanguage -t $TargetLanguage -e google -brief
	exit 0
} catch {
	Write-Error "ERROR in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
