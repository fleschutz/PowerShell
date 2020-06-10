#!/snap/bin/powershell
#
# PowerShell Script to Refresh the DNS Cache
# ------------------------------------------
# Author:  Markus Fleschutz
# Source:  github.com/fleschutz/PowerShell
# License: CC0

$DomainList = import-csv refresh_domains.csv

foreach($Domain in $DomainList) {
	ping -c 1 $Domain
}
exit 0
