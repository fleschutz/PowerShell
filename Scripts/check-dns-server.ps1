<#
.SYNOPSIS
	Check DNS servers
.DESCRIPTION
	This PowerShell script measures the availability and latency of public DNS servers and lists it.
.EXAMPLE
	PS> ./check-dns-server
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

function CheckDNS { param($Name, $IPv4Pri, $IPv4Sec)
	$StopWatch = [system.diagnostics.stopwatch]::startNew()
	$null = (nslookup fleschutz.de $IPv4Pri 2>$null)
	[int]$Elapsed1 = $StopWatch.Elapsed.TotalMilliseconds

	$StopWatch = [system.diagnostics.stopwatch]::startNew()
	$null = (nslookup fleschutz.de $IPv4Sec 2>$null)
	[int]$Elapsed2 = $StopWatch.Elapsed.TotalMilliseconds

	New-Object PSObject -Property @{ DNS_server=$Name; IPv4="$IPv4Pri / $IPv4Sec"; Latency="$Elapsed1 / $Elapsed2 ms" }
}

function ListDNSServerSpeed {
	Write-Progress "Measuring latency of public DNS servers..."
	CheckDNS "Cloudflare (standard)"                       1.1.1.1 1.0.0.1
	CheckDNS "Cloudflare (with malware blocklist)"         1.1.1.2 1.0.0.2
	CheckDNS "Cloudflare (with malware+adult blocklist)"   1.1.1.3 1.0.0.3
	CheckDNS "DNS0.eu (standard)"                          193.110.81.0 185.253.5.0
	CheckDNS "DNS0.eu (for kids)"                          193.110.81.1 185.253.5.1
	CheckDNS "DNS0.eu (zero)"                              193.110.81.9 185.253.5.9
	CheckDNS "Google Public DNS"                           8.8.8.8 8.8.4.4
	CheckDNS "Level3 one"                                  4.2.2.1 4.2.2.1
	CheckDNS "Level3 two"                                  4.2.2.2 4.2.2.2 
	CheckDNS "Level3 three"                                4.2.2.3 4.2.2.3
	CheckDNS "Level3 four"                                 4.2.2.4 4.2.2.4
	CheckDNS "Level3 five"                                 4.2.2.5 4.2.2.5
	CheckDNS "Level3 six"                                  4.2.2.6 4.2.2.6
	CheckDNS "OpenDNS Basic"                               208.67.222.222 208.67.220.220 
	CheckDNS "OpenDNS Family Shield"                       208.67.222.123 208.67.220.123 
	CheckDNS "OpenNIC"                                     94.247.43.254 94.247.43.254
	CheckDNS "Quad9 (with malware blocklist, with DNSSEC)" 9.9.9.9 9.9.9.9
	CheckDNS "Quad9 (no malware blocklist, no DNSSEC)"     9.9.9.10 9.9.9.10
	CheckDNS "Quad9 (with malware blocklist, with DNSSEC, with EDNS)" 9.9.9.11 9.9.9.11
	CheckDNS "Quad9 (with malware blocklist, with DNSSEC, NXDOMAIN only)" 9.9.9.12 9.9.9.12 
	CheckDNS "Verisign Public DNS"                         64.6.64.6 64.6.65.6
	Write-Progress -completed " "
}
 
try {
	ListDNSServerSpeed | Format-Table -property @{e='DNS_server';width=50},@{e='IPv4';width=32},@{e='Latency';width=15}
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}