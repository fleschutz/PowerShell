<#
.SYNOPSIS
	Checks the VPN connection
.DESCRIPTION
	This PowerShell script queries and prints the status of any VPN connection.
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
		$Connections = (Get-VPNConnection)
		foreach($Connection in $Connections) {
			"✅ VPN '$($Connection.Name)' is $($Connection.ConnectionStatus)"
			$NoVPN = $false
		}
	}
	if ($NoVPN) { "⚠️ No VPN connection" }
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
