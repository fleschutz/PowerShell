﻿<#
.SYNOPSIS
	Disconnects the VPN
.DESCRIPTION
	This PowerShell script disconnects the active VPN connection.
.EXAMPLE
	PS> ./disconnect-vpn.ps1
	Disconnected now.
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

try {
	$Connections = (Get-VPNConnection)
	foreach($Connection in $Connections) {
		if ($Connection.ConnectionStatus -ne "Connected") { continue }
		"Disconnecting $($Connection.Name)..."
		& rasdial.exe "$($Connection.Name)" /DISCONNECT
		if ($lastExitCode -ne 0) { throw "Disconnect failed with exit code $lastExitCode" }
		"Disconnected now."
		exit 0 # success
	}
	throw "No VPN connection found."
} catch {
	"⚠️ ERROR: $($Error[0]) (script line $($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
