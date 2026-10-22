<#
.SYNOPSIS
	Checks the VPN status
.DESCRIPTION
	This PowerShell script queries the status of the computer's VPNs and prints it.
.EXAMPLE
	PS> ./check-vpn.ps1
	✅ Internet VPN to NASA L2TP is connected
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

try {
	$noVPN = $true
	if ($IsLinux) {
		# TODO
	} else {
		$VPNs = Get-VPNConnection
		foreach($VPN in $VPNs) {
			Write-Output "✅ Internet VPN to $($VPN.Name) is $($VPN.ConnectionStatus.ToLower())"
			$noVPN = $false
		}
	}
	if ($noVPN) { Write-Output "⚠️ No VPN configured" }
	exit 0 # success
} catch {
	Write-Output "⚠️ ERROR: $($Error[0]) (at line $($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
