<#
.SYNOPSIS
	Checks the DNS resolution with frequently used domain names
.DESCRIPTION
	This script checks the DNS resolution with frequently used domain names.
.EXAMPLE
	PS> ./check-dns-resolution
	✔️ 11.8 domains/sec (177 domains resolved in 15 sec)
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz · License: CC0
#>
 
try {
	$StopWatch = [system.diagnostics.stopwatch]::startNew()
	write-progress "Reading Data/domain-names.csv..."

	$PathToRepo = "$PSScriptRoot/.."
	$Table = import-csv "$PathToRepo/Data/domain-names.csv"

	foreach($Row in $Table) {
		write-progress "Resolving $($Row.Domain) ..."
		if ($IsLinux) {
			$Ignore = nslookup $Row.Domain
		} else {
			$Ignore = resolve-dnsName $Row.Domain
		}
	}
	$Count = $Table.Length

	[int]$Elapsed = $StopWatch.Elapsed.TotalSeconds
	$Average = [math]::round($Count / $Elapsed, 1)
	"✔️ DNS resolves $Average domains/sec ($Count in $Elapsed sec)"
	exit 0 # success
} catch {
	"⚠️ Error: $($Error[0]) ($($MyInvocation.MyCommand.Name):$($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
