#!/snap/bin/powershell
#
# PowerShell Script to Refresh the DNS Cache
# ------------------------------------------
# Author:  Markus Fleschutz
# Source:  github.com/fleschutz/PowerShell
# License: CC0

$DomainTable = import-csv refresh_domains.csv

foreach($Line in $DomainTable) {
	$Ignore = Invoke-WebRequest $Line.Domain
}
write-host "Done."
exit 0
