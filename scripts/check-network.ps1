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

" "
& "$PSScriptRoot/write-green.ps1" "   N E T W O R K"
& "$PSScriptRoot/ping-remote-hosts.ps1"
& "$PSScriptRoot/check-firewall"
& "$PSScriptRoot/check-dns.ps1"
& "$PSScriptRoot/check-vpn.ps1"
& "$PSScriptRoot/list-public-ip.ps1"
& "$PSScriptRoot/ping-local-hosts.ps1"
exit 0 # success