#!/snap/bin/powershell

# Syntax:	./train-dns-cache.ps1
# Description:	trains the DNS cache with frequently used domain names
# Author:	Markus Fleschutz
# Source:	github.com/fleschutz/PowerShell
# License:	CC0
 
$Table = import-csv domain_table.csv

try {
	$StartTime = Get-Date
	foreach($Row in $Table) {
		$Domain = $Row.Domain
		write-progress "Training DNS cache with $Domain ..."
		$Ignore = nslookup $Domain
	}

	$Count = $Table.Length
	$StopTime = Get-Date
	$TimeInterval = New-Timespan -start $StartTime -end $StopTime
	write-host "✔️ DNS cache trained with $Count domain names in $TimeInterval sec."
	exit 0
} catch { Write-Error $Error[0] }
exit 1
