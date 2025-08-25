<#
.SYNOPSIS
	Checks an IPv4 address for validity
.DESCRIPTION
	This PowerShell script checks the given IPv4 address for validity.
.PARAMETER Address
	Specifies the IPv4 address to check
.EXAMPLE
	PS> ./check-ipv4-address 192.168.11.22
	✅ IPv4 192.168.11.22 is valid
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

param([string]$Address = "")

function IsIPv4AddressValid { param([string]$IP)
	$RegEx = "^(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$"
	if ($IP -match $RegEx) {
		return $true
	} else {
		return $false
	}
}

try {
	if ($Address -eq "" ) { $Address = read-host "Enter IPv4 address to validate" }

	if (IsIPv4AddressValid $Address) {
		"✅ IPv4 $Address is valid"
		exit 0 # success
	} else {
		write-warning "Invalid IPv4 address: $Address"
		exit 1
	}
} catch {
	"⚠️ ERROR: $($Error[0]) (script line $($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
