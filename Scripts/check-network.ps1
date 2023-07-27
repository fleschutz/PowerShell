<#
.SYNOPSIS
	Checks the network details
.DESCRIPTION
	This PowerShell script queries the network details of the local computer and prints it.
.EXAMPLE
	PS> ./check-network.ps1

	N E T W O R K
	✅ Firewall enabled
	...
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

" "
& "$PSScriptRoot/write-green.ps1" "   N E T W O R K"
& "$PSScriptRoot/check-firewall"
& "$PSScriptRoot/check-ping.ps1"
& "$PSScriptRoot/check-dns.ps1"
& "$PSScriptRoot/check-vpn.ps1"
exit 0 # success