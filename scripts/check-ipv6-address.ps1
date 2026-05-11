<#
.SYNOPSIS
	Checks an IPv6 address for validity
.DESCRIPTION
	This PowerShell script checks the given IPv6 address for validity
.PARAMETER address
	Specifies the IPv6 address to check
.EXAMPLE
	PS> ./check-ipv6-address fe80::200:5aee:feaa:20a2
	✅ IPv6 fe80::200:5aee:feaa:20a2 is valid
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

param([string]$address = "")

function IsIPv6AddressValid { param([string]$IP)
	# match IPv6 addresses + zero compressed IPv6 addresses + link-local IPv6 addresses with zone index:
	$IPv6_regex = '(([0-9a-fA-F]{1,4}:){7,7}[0-9a-fA-F]{1,4}|([0-9a-fA-F]{1,4}:){1,7}:|([0-9a-fA-F]{1,4}:){1,6}:[0-9a-fA-F]{1,4}|([0-9a-fA-F]{1,4}:){1,5}(:[0-9a-fA-F]{1,4}){1,2}|([0-9a-fA-F]{1,4}:){1,4}(:[0-9a-fA-F]{1,4}){1,3}|([0-9a-fA-F]{1,4}:){1,3}(:[0-9a-fA-F]{1,4}){1,4}|([0-9a-fA-F]{1,4}:){1,2}(:[0-9a-fA-F]{1,4}){1,5}|[0-9a-fA-F]{1,4}:((:[0-9a-fA-F]{1,4}){1,6})|:((:[0-9a-fA-F]{1,4}){1,7}|:)|fe80:(:[0-9a-fA-F]{0,4}){0,4}%[0-9a-zA-Z]{1,}|::(ffff(:0{1,4}){0,1}:){0,1}((25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9])\.){3,3}(25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9])|([0-9a-fA-F]{1,4}:){1,4}:((25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9])\.){3,3}(25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9]))'

	# match IPv4-embedded IPv6 addresses + IPv4-mapped IPv6 addresses + IPv4-translated addresses:
	$IPv4_regex = '((25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9])\.){3,3}(25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9])'

	return ($IP -imatch "^$IPv6_regex$") -or ($IP -imatch "^IPv4_regex$")
}

try {
	if ($address -eq "" ) { $address = Read-Host "Enter IPv6 address to validate" }

	if (IsIPv6AddressValid $address) {
		"✅ Valid IPv6 address: $address"
		exit 0 # success
	} else {
		"⚠️ Invalid IPv6 address: $address"
		exit 1
	}
} catch {
	"⚠️ ERROR: $($Error[0]) (at line $($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
