<#
.SYNOPSIS
	Checks the network
.DESCRIPTION
	This PowerShell script queries the network details of the local computer and prints it.
.EXAMPLE
	PS> ./check-network.ps1

	   === N E T W O R K ===
	✅ Firewall enabled
	...
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

Write-Host "`n   === N E T W O R K ===" -foregroundColor green
& "$PSScriptRoot/check-firewall"
& "$PSScriptRoot/list-local-ip.ps1"
& "$PSScriptRoot/ping-local-devices.ps1"
& "$PSScriptRoot/list-network-shares.ps1"
& "$PSScriptRoot/list-internet-ip.ps1"
& "$PSScriptRoot/ping-internet.ps1"
& "$PSScriptRoot/check-dns.ps1"
& "$PSScriptRoot/check-vpn.ps1"
& "$PSScriptRoot/list-ssh-key.ps1"
exit 0 # success
