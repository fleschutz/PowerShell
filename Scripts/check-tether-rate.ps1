<#
.SYNOPSIS
	Checks the Tether rate
.DESCRIPTION
	This script queries the current Tether exchange rates and answers by text-to-speech (TTS).
.EXAMPLE
	PS> ./check-tether-rate
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

try {
	$Rates = (Invoke-WebRequest -uri "https://min-api.cryptocompare.com/data/price?fsym=USDT&tsyms=USD,EUR" -userAgent "curl" -useBasicParsing).Content | ConvertFrom-Json

	& "$PSScriptRoot/give-reply.ps1" "Tether is currently at $($Rates.USD) US$ and $($Rates.EUR) Euro."
	exit 0 # success
} catch {
	"⚠️ Error: $($Error[0]) ($($MyInvocation.MyCommand.Name):$($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
