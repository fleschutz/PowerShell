#!/snap/bin/powershell
#
# PowerShell Script to Train the DNS Cache
# ----------------------------------------
# Author:  Markus Fleschutz
# Source:  github.com/fleschutz/PowerShell
# License: CC0

$DomainTable = import-csv domain_table.csv

foreach($Row in $DomainTable) {
	$DomainName = $Row.Domain
	write-progress "Training DNS cache: $DomainName ..."
	$Ignore = Resolve-DnsName $DomainName
}

$Count = $DomainTable.Length
write-host "OK - trained DNS cache with $Count domain names from domain_table.csv"
exit 0
