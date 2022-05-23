<#
.SYNOPSIS
	Checks the DNS resolution 
.DESCRIPTION
	This PowerShell script checks the DNS resolution with frequently used domain names.
.EXAMPLE
	PS> ./check-dns
	✔️ DNS resolution is 11.8 domains per second
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz / License: CC0
#>
 
try {
	$StopWatch = [system.diagnostics.stopwatch]::startNew()
	write-progress "Reading Data/domain-names.csv..."

	$PathToRepo = "$PSScriptRoot/.."
	$Table = import-csv "$PathToRepo/Data/domain-names.csv"

	if ($IsLinux) {
		foreach($Row in $Table) {
			write-progress "Resolving $($Row.Domain)..."
			$null = dig $Row.Domain +short
		}
	} else {
		foreach($Row in $Table) {
			write-progress "Resolving $($Row.Domain)..."
			$null = resolve-dnsName $Row.Domain
		}
	}
	$Count = $Table.Length

	[int]$Elapsed = $StopWatch.Elapsed.TotalSeconds
	$Average = [math]::round($Count / $Elapsed, 1)

	& "$PSScriptRoot/give-reply.ps1" "$Average domains per second DNS resolution"
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
