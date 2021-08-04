<#
.SYNOPSIS
	list-exchange-rates.ps1 [<currency>]
.DESCRIPTION
	Lists the exchange rates for the given currency (USD per default)
.EXAMPLE
	PS> .\list-exchange-rates.ps1
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author:  Markus Fleschutz
	License: CC0
#>

param([string]$currency = "USD")

function ListExchangeRates { param([string]$currency)
	[xml]$ExchangeRates = (invoke-webRequest -uri "http://www.floatrates.com/daily/$($currency).xml" -userAgent "curl" -useBasicParsing).Content 
	foreach($Row in $ExchangeRates.channel.item) {
		new-object PSObject -property @{ 'Rate' = "$($Row.exchangeRate)"; 'Currency' = "$($Row.targetCurrency) - $($Row.targetName)"; 'Inverse' = "$($Row.inverseRate)"; 'Date' = "$($Row.pubDate)" }
	}
}

try {
	""
	"Exchange Rates for 1 $currency (source: http://www.floatrates.com)"
	"============================================================"

	ListExchangeRates $currency | format-table -property Rate,Currency,Inverse,Date
	exit 0
} catch {
	write-error "⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
