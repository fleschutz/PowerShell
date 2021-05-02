<#
.SYNTAX       check-ipv4-address.ps1 [<address>]
.DESCRIPTION  checks the given IPv4 address for validity
.LINK         https://github.com/fleschutz/PowerShell
.NOTES        Author: Markus Fleschutz / License: CC0
#>

param($Address = "")

function IsIPv4AddressValid { param([string]$IP)
	$RegEx = "^(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$"
	if ($IP -match $RegEx) {
		return $true
	} else {
		return $false
	}
}

try {
	if ($Address -eq "" ) {
		$Address = read-host "Enter IPv4 address to validate"
	}
	if (IsIPv4AddressValid $Address) {
		write-host -foregroundColor green "OK - IPv4 address $Address is valid"
		exit 0
	} else {
		write-warning "Invalid IPv4 address: $Address"
		exit 1
	}
} catch {
	write-error "⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
