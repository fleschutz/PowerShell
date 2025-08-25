<#
.SYNOPSIS
	Lists system devices
.DESCRIPTION
	This PowerShell script lists all system devices connected to the local computer.
.EXAMPLE
	PS> ./list-system-devices.ps1

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
	Get-PnpDevice | Where-Object {$_.Class -like "System"} | Format-Table -property FriendlyName,Status,InstanceId
	exit 0 # success
} catch {
	"⚠️ ERROR: $($Error[0]) (script line $($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
