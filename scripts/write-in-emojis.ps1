<#
.SYNOPSIS
        Writes text in Emojis
.DESCRIPTION
        This PowerShell script replaces certain words in the given text by Emojis and writes it to the console.
.PARAMETER text
        Specifies the text
.EXAMPLE
        PS> ./write-in-emojis.ps1 "I love my folder"
        I💘️my📂
.LINK
        https://github.com/fleschutz/PowerShell
.NOTES
        Author: Markus Fleschutz | License: CC0
#>

param([string]$text = "")

try {
	if ($text -eq "")  { $text = Read-Host "Enter the text" }
	
	$table = Import-CSV "$PSScriptRoot/../data/emojis.csv"
	foreach($row in $table) {
		$text = $text -Replace "\s?$($row.WORD)\s?","$($row.EMOJI)️"
	}
	Write-Output $text
	exit 0 # success
} catch {
	"⚠️ ERROR: $($Error[0]) (script line $($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
