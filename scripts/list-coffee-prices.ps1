<#
.SYNOPSIS
	List coffee prices
.DESCRIPTION
	This PowerShell script queries alphavantage.co and lists the global price of coffee (monthly, in cents per points).
.EXAMPLE
	PS> ./list-coffee-prices.ps1
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

function WriteHorizontalBar { param([float]$Value, [float]$Max)
	$Num = ($Value * 100.0) / $Max
	while ($Num -ge 1.0) { Write-Host "█" -noNewline; $Num -= 1.0 }
	if ($Num -ge 0.875) {
		Write-Host "▉" -noNewline
	} elseif ($Num -ge 0.75) {
		Write-Host "▊" -noNewline
	} elseif ($Num -ge 0.625) {
		Write-Host "▋" -noNewline
	} elseif ($Num -ge 0.5) {
		Write-Host "▌" -noNewline
	} elseif ($Num -ge 0.375) {
		Write-Host "▍" -noNewline
	} elseif ($Num -ge 0.25) {
		Write-Host "▎" -noNewline
	} elseif ($Num -ge 0.125) {
		Write-Host "▏" -noNewline
	}
	Write-Host " $Value"
}

try {
	Write-Progress "Loading data from www.alphavantage.co..."
	$prices = (Invoke-WebRequest -URI "https://www.alphavantage.co/query?function=COFFEE&interval=monthly&apikey=demo" -userAgent "curl" -useBasicParsing).Content | ConvertFrom-Json
	Write-Progress -completed " "

	""
	"$($prices.name) (by alphavantage.co, in $($prices.unit))"
	"---------------------------------------------------------------"
	foreach($item in $prices.data) {
		if ($Item.value -eq ".") { continue }
		Write-Host "$($item.date) " -noNewline
		[int]$value = $Item.value
		WriteHorizontalBar $value 350.0
	}
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
