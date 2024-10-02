<#
.SYNOPSIS
	Check the DNS resolution 
.DESCRIPTION
	This PowerShell script measures the DNS resolution speed using 100 internet domains and prints it.
.EXAMPLE
	PS> ./check-dns.ps1
	✅ Internet DNS resolves 56.5 domains/sec
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
	[float]$elapsed = $stopWatch.Elapsed.TotalSeconds

	$speed = [math]::round($table.Length / $elapsed, 1)
	if ($speed -lt 10.0) {
		Write-Host "⚠️ Internet DNS resolves $speed domains/sec only"
	} else {  
		Write-Host "✅ Internet DNS resolves $speed domains/sec"
	}
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
