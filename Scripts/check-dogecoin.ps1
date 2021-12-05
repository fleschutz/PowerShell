<#
.SYNOPSIS
	Checks the Dogecoin rate
.DESCRIPTION
	This script queries the current Dogecoin exchange rates and answers by text-to-speech (TTS).
.EXAMPLE
	PS> ./check-dogecoin
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

try {
	$Rates = (Invoke-WebRequest -uri "https://min-api.cryptocompare.com/data/price?fsym=DOGE&tsyms=USD,EUR" -userAgent "curl" -useBasicParsing).Content | ConvertFrom-Json
	$Reply = "Dogecoin is currently at $($Rates.USD) US$ and $($Rates.EUR) Euro."
	"✔️ $Reply"
	& "$PSScriptRoot/speak-english.ps1" "$Reply"
	exit 0 # success
} catch {
	"⚠️ Error: $($Error[0]) ($($MyInvocation.MyCommand.Name):$($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
