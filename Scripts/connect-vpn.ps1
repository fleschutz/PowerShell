<#
.SYNOPSIS
	Connects to the VPN
.DESCRIPTION
	This PowerShell script tries to connect to the VPN.
.EXAMPLE
	PS> ./connect-vpn
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

try {
	$Connections = (Get-VPNConnection)
	foreach($Connection in $Connections) {
		if ($Connection.ConnectionStatus -eq "Connected") { throw "Already connected to VPN $($Connection.Name)" }
		if ($Connection.ConnectionStatus -ne "Disconnected") { continue }
		"Connecting to VPN $($Connection.Name)..."
		& rasdial.exe "$($Connection.Name)"
		if ($lastExitCode -ne "0") { throw "Cannot establish connection" }
		"Connected now."
		exit 0 # success 
	}
	throw "No VPN connection available"
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
