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

function WriteBar { param([string]$Text, [float]$Value, [float]$Max)
	$Num = $Value
	if ($Num -gt $Max) { $Num = $Max }
	$Num = ($Num * 70.0) / $Max
	while ($Num -ge 1.0) {
		write-host -noNewLine "█"
		$Num -= 1.0
	}
	if ($Num -ge 0.875) {
		write-host -noNewLine "▉"
	} elseif ($Num -ge 0.75) {
		write-host -noNewLine "▊"
	} elseif ($Num -ge 0.625) {
		write-host -noNewLine "▋"
	} elseif ($Num -ge 0.5) {
		write-host -noNewLine "▌"
	} elseif ($Num -ge 0.375) {
		write-host -noNewLine "▍"
	} elseif ($Num -ge 0.25) {
		write-host -noNewLine "▎"
	} elseif ($Num -ge 0.125) {
		write-host -noNewLine "▏"
	}
	write-host " $Value $Text"
}

try {
	"                                           Exchange Rates Today for 1 $currency"
	"                                           =============================="
	"                                          Source: http://www.floatrates.com"
	""

	[xml]$ExchangeRates = (invoke-webRequest -uri "http://www.floatrates.com/daily/$($currency).xml").Content 
	foreach($Row in $ExchangeRates.channel.item) {
		[string]$Name = $Row.targetName
		[float]$Value = $Row.exchangeRate
		WriteBar $Name $Value 10.0 
	}
	exit 0
} catch {
	write-error "⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
