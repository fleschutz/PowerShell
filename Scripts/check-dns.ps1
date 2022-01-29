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

	& "$PSScriptRoot/give-reply.ps1" "$Average domains per second DNS resolution"
	exit 0 # success
} catch {
	"⚠️ Error: $($Error[0]) ($($MyInvocation.MyCommand.Name):$($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
