#!/snap/bin/powershell
#
# Syntax:	./translate.ps1
# Description:	translates the given text
# Author:	Markus Fleschutz
# Source:	github.com/fleschutz/PowerShell
# License:	CC0

$SourceText = "Hello World!"
$SourceLang = "en"
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

foreach($TargetLang in $TargetLanguages) {
	$Result = TranslateWithGoogle $SourceText $SourceLang $TargetLang
	write-output $TargetLang" : "$Result
}
exit 0
