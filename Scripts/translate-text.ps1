#!/snap/bin/powershell

# Syntax:	./translate-text.ps1 [<text>]
# Description:	translates the given text into other languages
# Author:	Markus Fleschutz
# Source:	github.com/fleschutz/PowerShell
# License:	CC0

param([string]$SourceText)
if ($SourceText -eq "" ) {
	$SourceText = "Hello World!"
}
$SourceLanguage = "en"
$TargetLanguages = "af","da","de","el","es","hr","it","ja","ko","pl","pt","nl","ru","tr","uk","vi"

function TranslateWithGoogle {
	[CmdletBinding()]
	param (
	 	[Parameter(Position = 1, ValueFromPipeline = $true)]
	 	[ValidateNotNullorEmpty()]
	 	[string]$Text,

	 	[Parameter(Position = 2)]
	 	[ValidateNotNullorEmpty()]
	 	[string]$SourceLang,

	 	[Parameter(Position = 3)]
	 	[ValidateNotNullorEmpty()]
	 	[string]$TargetLang
	)

	$URL = "https://translate.googleapis.com/translate_a/single?client=gtx&sl=$($SourceLang)&tl=$($TargetLang)&dt=t&q=$($Text)"
	$result = Invoke-RestMethod $URL
	return $result[0][0][0]
}

try {
	foreach($TargetLanguage in $TargetLanguages) {
		$Result = TranslateWithGoogle $SourceText $SourceLanguage $TargetLanguage
		write-output $TargetLanguage" : "$Result
	}
	exit 0
} catch {
	Write-Error "ERROR in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
