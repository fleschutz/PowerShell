<#
.SYNOPSIS
	Checks the battery status
.DESCRIPTION
	This PowerShell script checks and prints the battery status.
.EXAMPLE
	PS> ./check-battery
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

try {
	if ($IsLinux) {
		# TODO
	} else {
		Add-Type -Assembly System.Windows.Forms
		$Details = [System.Windows.Forms.SystemInformation]::PowerStatus
		switch ($Details.PowerLineStatus) {
		"Online"  { $PowerStatus = "Plugged in to AC power" }
		"Offline" { $PowerStatus = "Disconnected from AC power" }
		}
		switch ($Details.BatteryChargeStatus) {
		"NoSystemBattery" { $BatteryStatus = "no system battery" }
		default           { $BatteryStatus = $Details.BatteryChargeStatus }
		}
		"✅ $PowerStatus, $BatteryStatus"
	}
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}