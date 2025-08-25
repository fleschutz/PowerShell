<#
.SYNOPSIS
	Checks the given subnet mask for validity
.DESCRIPTION
	This PowerShell script checks the given subnet mask for validity.
.PARAMETER address
	Specifies the subnet mask to check
.EXAMPLE
	PS> ./check-subnet-mask.ps1 255.255.255.0
	✅ subnet mask 255.255.255.0 is valid
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

param([string]$address = "")

function IsSubNetMaskValid { param([string]$IP)
	$RegEx = "^(254|252|248|240|224|192|128).0.0.0$|^255.(254|252|248|240|224|192|128|0).0.0$|^255.255.(254|252|248|240|224|192|128|0).0$|^255.255.255.(255|254|252|248|240|224|192|128|0)$"
	if ($IP -match $RegEx) {
		return $true
	} else {
		return $false
	}
}

try {
	if ($address -eq "" ) { $address = read-host "Enter subnet mask to validate" }

	if (IsSubNetMaskValid $address) {
		"✅ subnet mask $Address is valid"
		exit 0 # success
	} else {
		write-warning "Invalid subnet mask: $address"
		exit 1
	}
} catch {
	"⚠️ ERROR: $($Error[0]) (script line $($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
