#!/snap/bin/powershell
#
# Syntax:	train_dns_cache 
# Description:	trains the DNS cache with frequently used domain names
# Author:	Markus Fleschutz
# Source:	github.com/fleschutz/PowerShell
# License:	CC0
# 
$Table = import-csv domain_table.csv

$StartTime = Get-Date
foreach($Row in $Table) {
	$Domain = $Row.Domain
	write-progress "Training DNS cache with $Domain ..."
	$Ignore = nslookup $Domain
}

$Count = $Table.Length
$StopTime = Get-Date
$TimeInterval = New-Timespan -start $StartTime -end $StopTime
write-host "OK - DNS cache trained with $Count domain names in $TimeInterval sec."
exit 0
