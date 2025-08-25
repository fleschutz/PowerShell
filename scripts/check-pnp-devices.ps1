<#
.SYNOPSIS
	Checks PnP devices
.DESCRIPTION
	This PowerShell script checks all Plug'n'PLay devices connected to the local computer.
.EXAMPLE
	PS> ./check-pnp-devices.ps1

	FriendlyName                 Status  InstanceId
	------------                 ------  ----------
	Microsoft-Controller         OK      ROOT\SPACEPORT\0000
	...
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

try {
	Get-PnpDevice | Where-Object {$_.Status -like "Error"} | Format-Table -property FriendlyName,Status,InstanceId
	exit 0 # success
} catch {
	"⚠️ ERROR: $($Error[0]) (script line $($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
