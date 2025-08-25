<#
.SYNOPSIS
	Lists DNS servers
.DESCRIPTION
	This PowerShell script list public and free DNS servers together with IPv4 addresses and measured latency.
.EXAMPLE
	PS> ./list-dns-servers.ps1
      
	DNS PROVIDER            IPv4 ADDRESSES                   LATENCY
	------------            ---- ---------                   -------
	AdGuard DNS (Cyprus)    94.140.14.14 · 94.140.15.15      222 · 205 ms
	...
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

function MeasureDNSServer([string]$provider, [string]$IPv4Pri, [string]$IPv4Sec) {
	$time=[system.diagnostics.stopwatch]::startNew();$null=(nslookup fleschutz.de $IPv4Pri 2>$null);[int]$lat1=$time.Elapsed.TotalMilliseconds

	$time=[system.diagnostics.stopwatch]::startNew();$null=(nslookup fleschutz.de $IPv4Sec 2>$null);[int]$lat2=$time.Elapsed.TotalMilliseconds

	New-Object PSObject -Property @{ 'DNS PROVIDER'=$provider; 'IPv4 ADDRESSES'="$IPv4Pri · $IPv4Sec"; LATENCY="$lat1 · $lat2 ms" }
}

function List-DNS-Servers {
	Write-Progress "Loading data/public-dns-servers.csv..."
	$table = Import-CSV "$PSScriptRoot/../data/public-dns-servers.csv"
	Write-Progress -completed "Done."
	foreach($row in $table) { MeasureDNSServer $row.PROVIDER $row.IPv4_PRI $row.IPv4_SEC }
	
}
 
try {
	List-DNS-Servers | Format-Table -property @{e='DNS PROVIDER';width=50},@{e='IPv4 ADDRESSES';width=32},@{e='LATENCY';width=15}
	exit 0 # success
} catch {
	"⚠️ ERROR: $($Error[0]) (script line $($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
