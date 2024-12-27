<#
.SYNOPSIS
	Check the DNS resolution 
.DESCRIPTION
	This PowerShell script measures the DNS resolution speed using 100 internet domains and prints it.
.EXAMPLE
	PS> ./check-dns.ps1
	✅ Internet DNS: 33.6ms lookup time
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>
 
try {
	$table = Import-CSV "$PSScriptRoot/../data/popular-domains.csv"

	$stopWatch = [system.diagnostics.stopwatch]::startNew()
	if ($IsLinux) {
		foreach($row in $table){$nop=dig $row.Domain +short}
	} else {
		Clear-DnsClientCache
		foreach($row in $table){$nop=Resolve-DNSName $row.Domain}
	}
	[float]$elapsed = $stopWatch.Elapsed.TotalSeconds * 1000.0
	$speed = [math]::round($elapsed / $table.Length, 1)
	if ($speed -lt 10.0) {
		Write-Output "✅ Internet DNS: $($speed)ms excellent lookup time"
	} elseif ($speed -lt 100.0) {
		Write-Output "✅ Internet DNS: $($speed)ms lookup time"
	} else {  
		Write-Output "⚠️ Internet DNS: $($speed)ms slow lookup time"
	}
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
