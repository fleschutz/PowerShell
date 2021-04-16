#!/usr/bin/pwsh
<#
.SYNTAX       check-dns-resolution.ps1
.DESCRIPTION  checks the DNS resolution with frequently used domain names
.LINK         https://github.com/fleschutz/PowerShell
.NOTES        Author: Markus Fleschutz / License: CC0
#>
 
try {
	write-progress "Reading Data/domain-names.csv..."
	$StopWatch = [system.diagnostics.stopwatch]::startNew()

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

	$Elapsed = $StopWatch.Elapsed
	$Average = [math]::round($Count / $Elapsed.Seconds, 1)
	write-host -foregroundColor green "✔️ $Average domains/s ($Count domains resolved in $($Elapsed.Seconds) seconds)"
	exit 0
} catch {
	write-error "ERROR: line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
