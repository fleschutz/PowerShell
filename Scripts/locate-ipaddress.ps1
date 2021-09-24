<#
.SYNOPSIS
	locate-ipaddress.ps1 [<IPaddress>]
.DESCRIPTION
	Prints the geographic location of the given IP address
.EXAMPLE
	PS> ./locate-ipaddress 177.144.67.98
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

param([string]$IPaddr = "")

try {
	if ($IPaddr -eq "" ) { $IPaddr = read-host "Enter IP address to locate" }

	$result = Invoke-RestMethod -Method Get -Uri "http://ip-api.com/json/$IPaddr"
	write-output $result
	exit 0
} catch {
	"⚠️ Error: $($Error[0]) ($($MyInvocation.MyCommand.Name):$($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
