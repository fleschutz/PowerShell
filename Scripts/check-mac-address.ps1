#!/snap/bin/powershell
<#
.SYNTAX         ./check-mac-address.ps1 [<MAC>]
.DESCRIPTION	checks the given MAC address for validity
.LINK		https://github.com/fleschutz/PowerShell
.NOTES		Author:	Markus Fleschutz / License: CC0
#>

# Author:	Markus Fleschutz
# Source:	github.com/fleschutz/PowerShell
# License:	CC0

param([string]$MAC)

# MAC-Address like 00:00:00:00:00:00 or 00-00-00-00-00-00 or 000000000000
$RegEx = "^([0-9A-Fa-f]{2}[:-]){5}([0-9A-Fa-f]{2})|([0-9A-Fa-f]{2}){6}$"

try {
	if ($MAC -eq "" ) {
		$MAC = read-host "Enter MAC address to validate"
	}
	if ($MAC -match $RegEx) {
		write-output "MAC address $MAC is valid"
		exit 0
	} else {
		write-output "MAC address $MAC is NOT valid"
		exit 1
	}
} catch {
	write-error "ERROR in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
