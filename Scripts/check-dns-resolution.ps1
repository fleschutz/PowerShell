#!/usr/bin/pwsh
<#
.SYNTAX       check-dns-resolution.ps1
.DESCRIPTION  checks the DNS resolution with frequently used domain names
.LINK         https://github.com/fleschutz/PowerShell
.NOTES        Author: Markus Fleschutz / License: CC0
#>
 
try {
	$StartTime = Get-Date

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
	$StopTime = Get-Date
	$TimeInterval = New-Timespan -start $StartTime -end $StopTime
	$Average = [math]::round($Count / $TimeInterval.seconds, 1)
	write-host -foregroundColor green "OK - $Average domains/s ($Count domains resolved in $($TimeInterval.seconds) seconds)"
	exit 0
} catch {
	write-error "ERROR: line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
