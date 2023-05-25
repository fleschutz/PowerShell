<#
.SYNOPSIS
	List coffee prices
.DESCRIPTION
	This PowerShell script queries cryptocompare.com and lists the current crypto exchange rates in USD/EUR/RUB/CNY.
.EXAMPLE
	PS> ./list-crypto-rates
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

function WriteBar { param([string]$Text, [float]$Value, [float]$Max)
	Write-Host "$Text " -noNewline
	$Num = ($Value * 100.0) / $Max
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
	Write-Host " $Value"
}

try {
	$prices = (Invoke-WebRequest -URI "https://www.alphavantage.co/query?function=COFFEE&interval=monthly&apikey=demo" -userAgent "curl" -useBasicParsing).Content | ConvertFrom-Json
	""
	"$($prices.name) (by alphavantage.co, in $($prices.unit))"
	"---------------------------------------------------------------"
	foreach($item in $prices.data) {
		if ($Item.value -eq ".") { continue }
		[string]$date = $item.date
		[int]$value = $Item.value
		WriteBar $date $value 300.0
	}
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
