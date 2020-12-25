#!/snap/bin/powershell

# Syntax:	./translate-file.ps1 [<file>]
# Description:	translates the given file from source to target language.
# Author:	Markus Fleschutz
# Source:	github.com/fleschutz/PowerShell
# License:	CC0

param([string]$SourceFile, [string]$SourceLanguage, [string]$TargetLanguage)
try {
	if ($SourceFile -eq "" ) {
		$SourceFile = read-host "Enter path to file"
	}
	if ($SourceLanguage -eq "" ) {
		$SourceLanguage = read-host "Enter language of this file"
	}
	if ($TargetLanguage -eq "" ) {
		$TargetLanguage = read-host "Enter language to translate to"
	}

	$PathToRepo=(get-item $MyInvocation.MyCommand.Path).directory.parent

	Start-Process -FilePath "$PathToRepo/Data/trans" -ArgumentList "-i $SourceFile -s $SourceLanguage -t $TargetLanguage -e google -brief" -NoNewWindow -Wait
	exit 0
} catch {
	write-error "ERROR in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
