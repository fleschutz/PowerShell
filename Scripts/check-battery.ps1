<#
.SYNOPSIS
	Checks the battery
.DESCRIPTION
	This PowerShell script queries the status of the system battery and prints it.
.EXAMPLE
	PS> ./check-battery
	✅ 21% battery life, 54 min remaining
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

try {
	if ($IsLinux) {
		$Reply = "✅ AC powered" # TODO, just guessing :-)
	} else {
		Add-Type -Assembly System.Windows.Forms
		$Details = [System.Windows.Forms.SystemInformation]::PowerStatus
		[int]$Percent = 100 * $Details.BatteryLifePercent
		[int]$Remaining = $Details.BatteryLifeRemaining / 60
		switch ($Details.PowerLineStatus) {
		"Online"  {
			if ($Details.BatteryChargeStatus -eq "NoSystemBattery") {
				$Reply = "✅ AC powered"
			} elseif ($Percent -eq 100) {
				$Reply = "✅ Battery $Percent% full"
			} else {
				$Reply = "✅ Battery $Percent%, charging..."
			}
		}
		"Offline" {
			if ($Percent -eq 100) {
				$Reply = "✅ $Percent% full battery, $Remaining min remaining"
			} elseif ($Remaining -gt 30) {
				$Reply = "✅ $Percent% battery life, $Remaining min remaining"
			} else {
				$Reply = "⚠️ $Percent% battery life, only $Remaining min remaining"
			}
		}
		}
	}
	Write-Host $Reply
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}