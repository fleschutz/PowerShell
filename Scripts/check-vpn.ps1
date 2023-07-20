<#
.SYNOPSIS
	Checks the VPN status
.DESCRIPTION
	This PowerShell script queries and prints the status of the VPN connection(s).
.EXAMPLE
	PS> ./check-vpn.ps1
	✅ VPN to NASA L2TP is disconnected
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

try {
	$NoVPN = $true
	if ($IsLinux) {
		# TODO
	} else {
		$Connections = Get-VPNConnection
		foreach($Connection in $Connections) {
			Write-Host "✅ VPN to $($Connection.Name) is $($Connection.ConnectionStatus.ToLower())"
			$NoVPN = $false
		}
	}
	if ($NoVPN) { Write-Host "⚠️ No VPN configured" }
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
