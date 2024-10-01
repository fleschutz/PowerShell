<#
.SYNOPSIS
	Checks the network details
.DESCRIPTION
	This PowerShell script queries the network details of the local computer and prints it.
.EXAMPLE
	PS> ./check-network.ps1

	N E T W O R K
	✅ Online with 30ms latency (16ms..56ms, 0/10 loss)
	...
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

Write-Host "`n   N E T W O R K" -foregroundColor green
& "$PSScriptRoot/check-firewall"
& "$PSScriptRoot/list-ip-addresses.ps1"
& "$PSScriptRoot/ping-local-devices.ps1"
& "$PSScriptRoot/list-ssh-key.ps1"
& "$PSScriptRoot/ping-remote-hosts.ps1"
& "$PSScriptRoot/check-dns.ps1"
& "$PSScriptRoot/check-vpn.ps1"
exit 0 # success
