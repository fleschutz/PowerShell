#!/snap/bin/powershell

# Syntax:	./locate-ipaddress.ps1 [<IPaddress>]
# Description:	locates the geographic position of the given IP address
# Author:	Markus Fleschutz
# Source:	github.com/fleschutz/PowerShell
# License:	CC0
 
param([string]$IPaddr)
if ($IPaddr -eq "" ) {
	$IPaddr = read-host "Enter IP address to locate"
}

try {
	$result = Invoke-RestMethod -Method Get -Uri "http://ip-api.com/json/$IPaddr"
	write-host $result
	exit 0
} catch {
	Write-Error "ERROR in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
