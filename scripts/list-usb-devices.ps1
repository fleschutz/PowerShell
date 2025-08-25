<#
.SYNOPSIS
	Lists USB devices
.DESCRIPTION
	This PowerShell script lists all USB devices connected to the local computer.
.EXAMPLE
	PS> ./list-usb-devices.ps1

	FriendlyName                 Status  InstanceId
	------------                 ------  ----------
	USB-Root-Hub (USB 3.0)       OK      USB\ROOT_HUB30\4&2060378&0&0
	...
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

try {
	Get-PnpDevice | Where-Object {$_.Class -eq "USB"} | Sort-Object -property FriendlyName | Format-Table -property FriendlyName,Status,InstanceId
	exit 0 # success
} catch {
	"⚠️ ERROR: $($Error[0]) (script line $($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
