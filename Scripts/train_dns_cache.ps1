#!/snap/bin/powershell
#
# PowerShell Script to Train the DNS Cache
# ----------------------------------------
# Author:  Markus Fleschutz
# Source:  github.com/fleschutz/PowerShell
# License: CC0

$DomainTable = import-csv refresh_domains.csv

foreach($Row in $DomainTable) {
	$DomainName = $Row.Domain
	write-progress "Training $DomainName ..."
	$Ignore = dig $DomainName
}
write-host "Done."
exit 0
