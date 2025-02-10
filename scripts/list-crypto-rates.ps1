<#
.SYNOPSIS
	List crypto rates
.DESCRIPTION
	This PowerShell script queries the current crypto exchange rates from cryptocompare.com and lists it in USD/EUR/CNY/JPY.
.EXAMPLE
	PS> ./list-crypto-rates.ps1

	CRYPTOCURRENCY               USD                    EUR                    CNY                    JPY
	--------------               ---                    ---                    ---                    ---
	1 Bitcoin (BTC) =            97309.81               94385.57               38800                  14798679.56
	...
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

function ListCryptoRate { param([string]$Symbol, [string]$Name)
	$rates = (Invoke-WebRequest -URI "https://min-api.cryptocompare.com/data/price?fsym=$Symbol&tsyms=USD,EUR,CNY,JPY" -userAgent "curl" -useBasicParsing).Content | ConvertFrom-Json
	New-Object PSObject -property @{ 'CRYPTOCURRENCY' = "1 $Name ($Symbol) ="; 'USD' = "$($rates.USD)"; 'EUR' = "$($rates.EUR)"; 'CNY' = "$($rates.CNY)"; 'JPY' = "$($rates.JPY)" }
}

function ListCryptoRates { 
	ListCryptoRate BTC   "Bitcoin"
	ListCryptoRate ETH   "Ethereum"
	ListCryptoRate SOL   "Solana"
	ListCryptoRate XRP   "XRP"
	ListCryptoRate USDC  "USD Coin"
	ListCryptoRate SUI   "Sui"
	ListCryptoRate DOGE  "Dogecoin"
	ListCryptoRate TRUMP "Official Trump"
	ListCryptoRate USDT  "Tether"
	ListCryptoRate BUSD  "BUSD"
	ListCryptoRate AVAX  "Avalanche"
	ListCryptoRate LTC   "Litecoin"
	ListCryptoRate GALA  "Gala"
	ListCryptoRate ADA   "Cardano"
	ListCryptoRate BNB   "Binance Coin"
	ListCryptoRate DOT   "Polkadot"
	ListCryptoRate UNI   "Uniswap"
	ListCryptoRate BUSD  "Binance USD"
	ListCryptoRate BCH   "Bitcoin Cash"
	ListCryptoRate LINK  "Chainlink"
	ListCryptoRate LUNA  "Terra"
	ListCryptoRate ICP   "Internet Computer"
	ListCryptoRate WBTC  "Wrapped Bitcoin"
	ListCryptoRate MATIC "Polygon"
	ListCryptoRate XLM   "Stellar"
}

try {
	ListCryptoRates | Format-Table -property @{e='CRYPTOCURRENCY';width=28},USD,EUR,CNY,JPY
	Write-Host "(by https://www.cryptocompare.com • Crypto is volatile and unregulated • Capital at risk • Taxes may apply)"
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
