<#
.SYNOPSIS
	Checks the DNS speed 
.DESCRIPTION
	This PowerShell script measures the DNS resolution speed using 100 internet domains and prints it.
.EXAMPLE
	PS> ./check-dns.ps1
	✅ Internet DNS with 33.6ms average lookup time
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
		Write-Output "✅ Internet DNS with excellent $($speed)ms average lookup time"
	} elseif ($speed -lt 100.0) {
		Write-Output "✅ Internet DNS with $($speed)ms average lookup time"
	} else {  
		Write-Output "⚠️ Internet DNS with slow $($speed)ms average lookup time"
	}
	exit 0 # success
} catch {
	"⚠️ ERROR: $($Error[0]) (script line $($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
