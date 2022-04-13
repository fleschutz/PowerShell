<#
.SYNOPSIS
	Lists all Bluetooth devices
.DESCRIPTION
	This PowerShell script lists all Bluetooth devices.
.EXAMPLE
	PS> ./list-bluetooth-devices
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz / License: CC0
#>

try {
	Get-PnpDevice | Where-Object {$_.Class -eq "Bluetooth"}
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
