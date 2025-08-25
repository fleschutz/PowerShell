<#
.SYNOPSIS
	Lists the battery status
.DESCRIPTION
	This PowerShell script lists the battery status.
.EXAMPLE
	PS> ./list-battery-status.ps1

	PowerLineStatus      : Online
	BatteryChargeStatus  : NoSystemBattery
	...
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

try {
	Add-Type -Assembly System.Windows.Forms
	[System.Windows.Forms.SystemInformation]::PowerStatus
	exit 0 # success
} catch {
	"⚠️ ERROR: $($Error[0]) (script line $($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
