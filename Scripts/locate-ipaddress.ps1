<#
.SYNOPSIS
	locate-ipaddress.ps1 [<IPaddress>]
.DESCRIPTION
	Prints the geographic location of the given IP address
.EXAMPLE
	PS> .\locate-ipaddress.ps1 177.144.67.98
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz / License: CC0
#>

param($IPaddr = "")
if ($IPaddr -eq "" ) { $IPaddr = read-host "Enter IP address to locate" }

try {
	$result = Invoke-RestMethod -Method Get -Uri "http://ip-api.com/json/$IPaddr"
	write-output $result
	exit 0
} catch {
	write-error "⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
