#!/snap/bin/powershell
#
# Description:	trains the DNS cache with frequently used domain names
# Author:	Markus Fleschutz
# Source:	github.com/fleschutz/PowerShell
# License:	CC0
# 
$DomainTable = import-csv domain_table.csv

foreach($Row in $DomainTable) {
	$DomainName = $Row.Domain
	write-progress "Training DNS cache with $DomainName ..."
	$Ignore = Resolve-DnsName -Name $DomainName -DnsOnly
}

$Count = $DomainTable.Length
write-host "OK - trained DNS cache with $Count domain names from domain_table.csv"
exit 0
