<#
.SYNOPSIS
	Checks the DNS resolution 
.DESCRIPTION
	This PowerShell script checks the DNS resolution with frequently used domain names.
.EXAMPLE
	PS> ./check-dns
	11.8 domains per second DNS resolution
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>
 
try {
	$StopWatch = [system.diagnostics.stopwatch]::startNew()

	write-progress "Reading Data/domain-names.csv..."
	$Table = Import-CSV "$PSScriptRoot/../Data/domain-names.csv"

	if ($IsLinux) {
		foreach($Row in $Table) {
			write-progress "Resolving $($Row.Domain)..."
			$null = dig $Row.Domain +short
		}
	} else {
		foreach($Row in $Table) {
			write-progress "Resolving $($Row.Domain)..."
			$null = Resolve-dnsName $Row.Domain
		}
	}
	$Count = $Table.Length

	[int]$Elapsed = $StopWatch.Elapsed.TotalSeconds
	$Average = [math]::round($Count / $Elapsed, 1)
	"$Average domains per second DNS resolution"
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
