<#
.SYNOPSIS
	Check DNS resolution 
.DESCRIPTION
	This PowerShell script measures and prints the DNS resolution speed by using 200 popular domains.
.EXAMPLE
	PS> ./check-dns
	✅ DNS resolves 156.5 domains per second
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>
 
try {
	Write-Progress "⏳ Resolving 200 popular domain names..."
	$table = Import-CSV "$PSScriptRoot/../Data/popular-domains.csv"
	$numRows = $table.Length

	$stopWatch = [system.diagnostics.stopwatch]::startNew()
	if ($IsLinux) {
foreach($row in $table){$nop=dig $row.Domain +short}
	} else {
foreach($row in $table){$nop=Resolve-DNSName $row.Domain}
	}
	[float]$elapsed = $stopWatch.Elapsed.TotalSeconds

	
	$average = [math]::round($numRows / $elapsed, 1)
	if ($average -lt 10.0) {
		"⚠️ DNS resolves $average domains per second only!"
	} else {  
		"✅ DNS resolves $average domains per second"
	}
	Write-Progress -completed "."
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}