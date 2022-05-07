<#
.SYNOPSIS
	Checks DNS server
.DESCRIPTION
	This PowerShell script checks the speed of public DNS server.
.EXAMPLE
	PS> ./check-dns-server
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

function CheckDNS { param($Name, $PriIPv4, $SecIPv4)
	$StopWatch = [system.diagnostics.stopwatch]::startNew()
	$null = (nslookup whitehouse.gov $PriIPv4)
	[int]$PriIPv4Elapsed = $StopWatch.Elapsed.TotalMilliseconds

	$StopWatch = [system.diagnostics.stopwatch]::startNew()
	$null = (nslookup whitehouse.gov $SecIPv4)
	[int]$SecIPv4Elapsed = $StopWatch.Elapsed.TotalMilliseconds

	"   `"$Name`"; `"$PriIPv4`"; `"$PriIPv4Elapsed ms`"; `"$SecIPv4`"; `"$SecIPv4Elapsed ms`"; "
}
 
try {
	"Checking speed of public DNS server..."
	"  `"Company`"; `"IPv4 primary`"; `"Latency in ms`"; `"IPv4 secondary`"; `"Latency in ms`"; "
	CheckDNS "Cloudflare" 1.1.1.1 1.0.0.1
	CheckDNS "Cloudflare with malware blocklist" 1.1.1.2 1.0.0.2
	CheckDNS "Cloudflare with malware+adult blocklist" 1.1.1.3 1.0.0.3
	CheckDNS "DNS.Watch" 84.200.69.80 84.200.70.40 
	CheckDNS "FreeDNS Vienna" 37.235.1.174 37.235.1.177
	CheckDNS "Google Public DNS" 8.8.8.8 8.8.4.4
	CheckDNS "Level3 one" 4.2.2.1 4.2.2.1
	CheckDNS "Level3 two" 4.2.2.2 4.2.2.2 
	CheckDNS "Level3 three" 4.2.2.3 4.2.2.3
	CheckDNS "Level3 four" 4.2.2.4 4.2.2.4
	CheckDNS "Level3 five" 4.2.2.5 4.2.2.5
	CheckDNS "Level3 six" 4.2.2.6 4.2.2.6
	CheckDNS "OpenDNS Basic" 208.67.222.222 208.67.220.220 
	CheckDNS "OpenDNS Family Shield" 208.67.222.123 208.67.220.123 
	CheckDNS "OpenNIC" 94.247.43.254 94.247.43.254
	CheckDNS "Quad9 with malware blocklist, with DNSSEC" 9.9.9.9 9.9.9.9
	CheckDNS "Quad9, no malware blocklist, no DNSSEC" 9.9.9.10 9.9.9.10
	CheckDNS "Quad9, with malware blocklist, with DNSSEC, with EDNS" 9.9.9.11 9.9.9.11
	CheckDNS "Quad9, with malware blocklist, with DNSSEC, NXDOMAIN only" 9.9.9.12 9.9.9.12 
	CheckDNS "Verisign Public DNS" 64.6.64.6 64.6.65.6
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
