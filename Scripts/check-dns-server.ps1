<#
.SYNOPSIS
	Checks DNS server
.DESCRIPTION
	This PowerShell script checks the performance of public DNS server.
.EXAMPLE
	PS> ./check-dns-server
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

function CheckDNS { param($IP, $Name)
	$StopWatch = [system.diagnostics.stopwatch]::startNew()
	$null = (nslookup heise.de $IP)
	[int]$Elapsed = $StopWatch.Elapsed.TotalMilliseconds
	"                   $IP ($Name) = $Elapsed ms "
}
 
try {
	"Checking performance of public DNS server..."
	CheckDNS 217.237.150.188 "1&1"
	CheckDNS 217.237.150.33 "1&1"
	CheckDNS 217.237.150.141 "1&1"
	CheckDNS 1.1.1.1 Cloudflare
	CheckDNS 1.0.0.1 Cloudflare
	CheckDNS 1.1.1.2 "Cloudflare with malware blocklist"
	CheckDNS 1.0.0.2 "Cloudflare with malware blocklist"
	CheckDNS 1.1.1.3 "Cloudflare with malware+adult blocklist"
	CheckDNS 1.0.0.3 "Cloudflare with malware+adult blocklist" 
	CheckDNS 217.5.100.185 "Deutsche Telekom AG"
	CheckDNS 217.5.100.186 "Deutsche Telekom AG"
	CheckDNS 8.8.8.8 Google
	CheckDNS 8.8.4.4 Google 
	CheckDNS 4.2.2.1 "Level3 one"
	CheckDNS 4.2.2.2 "Level3 two"
	CheckDNS 4.2.2.3 "Level3 three"
	CheckDNS 4.2.2.4 "Level3 four"
	CheckDNS 4.2.2.5 "Level3 five"
	CheckDNS 4.2.2.6 "Level3 six"
	CheckDNS 9.9.9.9 "Quad9 with malware blocklist, with DNSSEC"
	CheckDNS 9.9.9.10 "Quad9, no malware blocklist, no DNSSEC"
	CheckDNS 9.9.9.11 "Quad9, with malware blocklist, with DNSSEC, with EDNS"
	CheckDNS 9.9.9.12 "Quad9, with malware blocklist, with DNSSEC, NXDOMAIN only"
	CheckDNS 217.237.151.97 "Telekom München"
	CheckDNS 217.237.151.161 "Telekom Stuttgart"
	CheckDNS 217.237.150.141 "Telekom Ulm"
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
