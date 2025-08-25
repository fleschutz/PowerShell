<#
.SYNOPSIS
	Lists SCSI devices
.DESCRIPTION
	This PowerShell script lists all SCSI devices connected to the local computer.
.EXAMPLE
	PS> ./list-scsi-devices.ps1

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
	Get-PnpDevice | Where-Object {$_.Class -like "SCSI*"} | Sort-Object -property FriendlyName | Format-Table -property FriendlyName,Status,InstanceId
	exit 0 # success
} catch {
	"⚠️ ERROR: $($Error[0]) (script line $($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
