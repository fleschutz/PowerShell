#!/snap/bin/powershell
#
# Syntax:	train_dns_cache 
# Description:	trains the DNS cache with frequently used domain names
# Author:	Markus Fleschutz
# Source:	github.com/fleschutz/PowerShell
# License:	CC0
# 
$Table = import-csv domain_table.csv

foreach($Row in $Table) {
	$Domain = $Row.Domain
	write-progress "Training DNS cache with $Domain ..."
	$Ignore = nslookup $Domain
}

$Count = $Table.Length
write-host "OK - trained DNS cache with $Count domain names from domain_table.csv"
exit 0
