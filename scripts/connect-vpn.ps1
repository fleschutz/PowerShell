<#
.SYNOPSIS
	Connects to the VPN
.DESCRIPTION
	This PowerShell script tries to connect to the VPN.
.EXAMPLE
	PS> ./connect-vpn.ps1
	⏳ Connecting to NASA-VPN..."
	✅ VPN connected.
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

try {
	$connections = (Get-VPNConnection)
	foreach($connection in $connections) {
		if ($connection.ConnectionStatus -eq "Connected") { throw "Already connected to VPN $($connection.Name)" }
		if ($connection.ConnectionStatus -ne "Disconnected") { continue }
		"⏳ Connecting to $($Connection.Name)..."
		& rasdial.exe "$($Connection.Name)"
		if ($lastExitCode -ne 0) { throw "Cannot establish connection" }
		"✅ VPN connected."
		exit 0 # success 
	}
	throw "No VPN connection available"
} catch {
	"⚠️ ERROR: $($Error[0])"
	exit 1
}
