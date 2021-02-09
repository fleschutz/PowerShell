#!/bin/powershell
<#
.SYNTAX         ./check-ipv4-address.ps1 [<address>]
.DESCRIPTION	checks the given IPv4 address for validity
.LINK		https://github.com/fleschutz/PowerShell
.NOTES		Author:	Markus Fleschutz / License: CC0
#>

param([string]$Addr)

# IPv4-Address like 192.168.178.1
$RegEx = "^(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$"

try {
	if ($Addr -eq "" ) {
		$Addr = read-host "Enter IPv4 address to validate"
	}
	if ($Addr -match $RegEx) {
		write-output "IPv4 address $Addr is valid"
		exit 0
	} else {
		write-output "IPv4 address $Addr is NOT valid"
		exit 1
	}
} catch {
	write-error "ERROR in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
