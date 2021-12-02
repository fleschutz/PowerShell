<#
.SYNOPSIS
	Checks the VPN connection(s)
.DESCRIPTION
	This script checks the VPN connection(s).
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
		$Reply += "VPN connection $($Connection.Name) is $($Connection.ConnectionStatus), "
	}
	if ("$Reply" -eq "") { $Reply = "No VPN connection available" }

	"✔️ $Reply"
	& "$PSScriptRoot/speak-english.ps1" "$Reply"
	exit 0 # success
} catch {
	"⚠️ Error: $($Error[0]) ($($MyInvocation.MyCommand.Name):$($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
