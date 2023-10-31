<#
.SYNOPSIS
	Adds a memo text 
.DESCRIPTION
	This PowerShell script saves the given memo text to Memos.csv in your home folder.
.PARAMETER text
	Specifies the text to memorize
.EXAMPLE
	PS> ./add-memo.ps1 "Buy apples"
	✔️ saved to 📄/home/markus/Memos.csv
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

param([string]$text = "")

try {
	if ($text -eq "" ) { $text = Read-Host "Enter the text to memorize" }

	$Path = "~/Memos.csv"
	$Time = Get-Date -format FileDateTimeUniversal
	$Line = "$Time,$text"

	if (-not(Test-Path "$Path" -pathType leaf)) {
		Write-Output "TIME,TEXT" > "$Path"
	}
	Write-Output $Line >> "$Path"

	"✔️ saved to 📄$Path"
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
