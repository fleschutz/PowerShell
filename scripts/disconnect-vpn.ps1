<#
.SYNOPSIS
	Disconnects the VPN
.DESCRIPTION
	This PowerShell script disconnects the active VPN connection.
.EXAMPLE
	PS> ./disconnect-vpn.ps1
	⏳ Disconnecting NASA-VPN...
	✅ VPN disconnected.
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

try {
	$connections = (Get-VPNConnection)
	foreach($connection in $connections) {
		if ($connection.ConnectionStatus -ne "Connected") { continue }
		"⏳ Disconnecting $($connection.Name)..."
		& rasdial.exe "$($connection.Name)" /DISCONNECT
		if ($lastExitCode -ne 0) { throw "Disconnect failed with exit code $lastExitCode" }
		"✅ VPN disconnected."
		exit 0 # success
	}
	throw "No VPN connection found."
} catch {
	"⚠️ ERROR: $($Error[0])"
	exit 1
}
