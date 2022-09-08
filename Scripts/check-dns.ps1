<#
.SYNOPSIS
	Checks the DNS resolution 
.DESCRIPTION
	This PowerShell script checks the DNS resolution using frequently used domain names.
.EXAMPLE
	PS> ./check-dns
	56.7 domains per second DNS resolution
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>
 
try {
	write-progress "Reading table from Data/domain-names.csv..."
	$Table = Import-CSV "$PSScriptRoot/../Data/domain-names.csv"
	$Count = $Table.Length

	write-progress "Resolving $Count domain names..."
	$StopWatch = [system.diagnostics.stopwatch]::startNew()
	if ($IsLinux) {
		foreach($Row in $Table) { $null = dig $Row.Domain +short }
	} else {
		foreach($Row in $Table) { $null = Resolve-DNSName $Row.Domain }
	}
	[float]$Elapsed = $StopWatch.Elapsed.TotalSeconds

	$Average = [math]::round($Count / $Elapsed, 1)
	"$Average domains per second DNS resolution"
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}