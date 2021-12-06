<#
.SYNOPSIS
	Checks the VPN connections
.DESCRIPTION
	This script checks all available VPN connections.
.EXAMPLE
	PS> ./check-vpn
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz · License: CC0
#>

try {
	$Connections = (Get-VPNConnection)
	$Reply = ""
	foreach($Connection in $Connections) {
		if ("$Reply" -eq "") { $Reply += "VPN connection " } else { $Reply += ", " }
		$Reply += "$($Connection.Name) is $($Connection.ConnectionStatus)"
	}
	if ("$Reply" -eq "") { $Reply = "No VPN connection available" }

	& "$PSScriptRoot/give-reply.ps1" "$Reply"
	exit 0 # success
} catch {
	"⚠️ Error: $($Error[0]) ($($MyInvocation.MyCommand.Name):$($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
