<#
.SYNOPSIS
	Checks the VPN status
.DESCRIPTION
	This PowerShell script queries the status of the VPN connections and prints it.
.EXAMPLE
	PS> ./check-vpn
	✅ Disconnected VPN 'NASA L2TP' 
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
			"✅ $($Connection.ConnectionStatus) VPN '$($Connection.Name)'"
			$NoVPN = $false
		}
	}
	if ($NoVPN) { "⚠️ No VPN" }
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
