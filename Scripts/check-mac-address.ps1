<#
.SYNOPSIS
	check-mac-address.ps1 [<MAC>]
.DESCRIPTION
	Checks the given MAC address for validity
        MAC address like 00:00:00:00:00:00 or 00-00-00-00-00-00 or 000000000000
.EXAMPLE
	PS> .\check-mac-address.ps1 11:22:33:44:55:66
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author:  Markus Fleschutz
	License: CC0
#>

param([string]$MAC = "")

function IsMACAddressValid { param([string]$mac)
	$RegEx = "^([0-9A-Fa-f]{2}[:-]){5}([0-9A-Fa-f]{2})|([0-9A-Fa-f]{2}){6}$"
	if ($mac -match $RegEx) {
		return $true
	} else {
		return $false
	}
}

try {
	if ($MAC -eq "" ) {
		$MAC = read-host "Enter MAC address to validate"
	}
	if (IsMACAddressValid $MAC) {
		"✔️ MAC address $MAC is valid"
		exit 0
	} else {
		write-warning "Invalid MAC address: $MAC"
		exit 1
	}
} catch {
	write-error "⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
