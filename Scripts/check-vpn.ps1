<#
.SYNOPSIS
	Checks the VPN connection
.DESCRIPTION
	This PowerShell script queries status of the VPN connections and prints it.
.EXAMPLE
	PS> ./check-vpn
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
			Write-Host "✅ VPN '$($Connection.Name)' is $($Connection.ConnectionStatus)"
			$NoVPN = $false
		}
	}
	if ($NoVPN) { Write-Host "⚠️ No VPN connection" }
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}