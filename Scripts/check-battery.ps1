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
		switch ($Details.BatteryChargeStatus) {
		"NoSystemBattery" { $BatteryStatus = "No battery" }
		"0"			{ [int]$Life = 100*$Details.BatteryLifePercent; [int]$Remaining = $Details.BatteryLifeRemaining / 60; $BatteryStatus = "Battery $Life%, $Remaining min left" }
		default           { $BatteryStatus = $Details.BatteryChargeStatus }
		}
		switch ($Details.PowerLineStatus) {
		"Online"  { $PowerStatus = "plugged in to AC power" }
		"Offline" { $PowerStatus = "disconnected from AC power" }
		}
		"✅ $BatteryStatus, $PowerStatus"
	}
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}