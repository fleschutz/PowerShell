#!/snap/bin/powershell
#
# PowerShell Script to Refresh the DNS Cache
# ------------------------------------------
# Author:  Markus Fleschutz
# Source:  github.com/fleschutz/PowerShell
# License: CC0

Resolve-DnsName -name bing.com -DnsOnly
exit 0
