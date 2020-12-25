#!/snap/bin/powershell

# Syntax:	./locate-ipaddress.ps1 [<IPaddress>]
# Description:	prints the geographic location of the given IP address
# Author:	Markus Fleschutz
# Source:	github.com/fleschutz/PowerShell
# License:	CC0
 
param([string]$IPaddr)
try {
	if ($IPaddr -eq "" ) {
		$IPaddr = read-host "Enter IP address to locate"
	}
	$result = Invoke-RestMethod -Method Get -Uri "http://ip-api.com/json/$IPaddr"
	write-output $result
	exit 0
} catch {
	write-error "ERROR in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
