<#
.SYNOPSIS
	Lists Bluetooth devices
.DESCRIPTION
	This PowerShell script lists all Bluetooth devices connected to the local computer.
.EXAMPLE
	PS> ./list-bluetooth-devices.ps1

	FriendlyName                 Status  InstanceId
	------------                 ------  ----------
	G3 Headset                   OK      BTHENUM\DEV_FC58FA7A51C6\8&152049BE&0&BLUETOOTHDEVICE_FC58FA7A51C6
	...
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

try {
	Get-PnpDevice | Where-Object {$_.Class -eq "Bluetooth"} | Sort-Object -property FriendlyName | Format-Table -property FriendlyName,Status,InstanceId
	exit 0 # success
} catch {
	"⚠️ ERROR: $($Error[0]) (script line $($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
