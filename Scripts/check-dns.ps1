<#
.SYNOPSIS
	Check the DNS resolution 
.DESCRIPTION
	This PowerShell script measures the DNS resolution speed (using 100 popular domains) and prints it.
.EXAMPLE
	PS> ./check-dns.ps1
	✅ DNS resolves 56.5 domains per second
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>
 
try {
	$table = Import-CSV "$PSScriptRoot/../Data/popular-domains.csv"
	$numRows = $table.Length
	Write-Progress "⏳ Resolving $numRows domain names..."

	$stopWatch = [system.diagnostics.stopwatch]::startNew()
	if ($IsLinux) {
		foreach($row in $table){$nop=dig $row.Domain +short}
	} else {
		foreach($row in $table){$nop=Resolve-DNSName $row.Domain}
	}
	Write-Progress -completed "."
	[float]$elapsed = $stopWatch.Elapsed.TotalSeconds
	$average = [math]::round($numRows / $elapsed, 1)
	if ($average -lt 10.0) {
		Write-Output "⚠️ DNS resolves $average domains per second only"
	} else {  
		Write-Output "✅ DNS resolves $average domains per second"
	}
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
