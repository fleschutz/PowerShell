<#
.SYNOPSIS
	Lists all Bluetooth devices
.DESCRIPTION
	This script lists all Bluetooth devices.
.EXAMPLE
	PS> ./list-bluetooth-devices
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

try {
	Get-PnpDevice | Where-Object {$_.Class -eq "Bluetooth"}
	exit 0 # success
} catch {
	"⚠️ Error: $($Error[0]) ($($MyInvocation.MyCommand.Name):$($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
