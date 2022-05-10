<#
.SYNOPSIS
	Checks the VPN connections
.DESCRIPTION
	This PowerShell script checks the status of all available VPN connections.
.EXAMPLE
	PS> ./check-vpn
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

try {
	$FoundOne = $false
	$Connections = (Get-VPNConnection)
	foreach($Connection in $Connections) {
		"VPN $($Connection.Name) is $($Connection.ConnectionStatus)."
		$FoundOne = $true
	}
	if (!$FoundOne) { throw "No VPN connection available" }
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
