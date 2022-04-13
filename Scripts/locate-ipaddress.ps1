<#
.SYNOPSIS
	Prints the geo location of the given IP address
.DESCRIPTION
	This PowerShell script prints the geographic location of the given IP address.
.PARAMTER IPaddress
	Specifies the IP address
.EXAMPLE
	PS> ./locate-ipaddress 177.144.67.98
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz / License: CC0
#>

param([string]$IPaddress= "")

try {
	if ($IPaddress -eq "" ) { $IPaddress = read-host "Enter IP address to locate" }

	$result = Invoke-RestMethod -Method Get -Uri "http://ip-api.com/json/$IPaddress"
	write-output $result
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
