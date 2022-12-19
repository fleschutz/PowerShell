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
		$Status = "✅"
		switch ($Details.PowerLineStatus) {
		"Online"  { $Power = "AC powered" }
		"Offline" { $Power = "No AC power" }
		}
		if ($Details.BatteryChargeStatus -eq "NoSystemBattery") {
			$Battery = "no system battery"
		} else {
			[int]$Percent = 100 * $Details.BatteryLifePercent
			[int]$Remaining = $Details.BatteryLifeRemaining / 60
			if ($Remaining -lt 30) { $Status = "⚠️" }
			$Battery = "$Percent% battery life, $Remaining min. left"
		}
		"$Status $Power, $Battery"
	}
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}