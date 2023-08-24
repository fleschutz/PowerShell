<#
.SYNOPSIS
	Checks the power status
.DESCRIPTION
	This PowerShell script queries the power status and prints it.
.EXAMPLE
	PS> ./check-power.ps1
	⚠️ Battery at 9% (54 min remaining) with power scheme: HP Optimized 
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
		if ($Details.PowerLineStatus -eq "Online") {
			if ($Details.BatteryChargeStatus -eq "NoSystemBattery") {
				$Reply = "✅ AC powered"
			} elseif ($Percent -ge 95) {
				$Reply = "✅ Battery fully charged ($Percent%)"
			} else {
				$Reply = "✅ Battery charging... ($Percent%)"
			}
		} else { # must be offline
			if ($Remaining -eq 0) {
				$Reply = "✅ Battery at $Percent%"
			} elseif ($Remaining -le 5) {
				$Reply = "⚠️ Battery at $Percent%, ONLY $Remaining MIN remaining"
			} elseif ($Remaining -le 30) {
				$Reply = "⚠️ Battery at $Percent%, only $Remaining min remaining"
			} elseif ($Percent -lt 10) {
				$Reply = "⚠️ Battery at $Percent% with $Remaining min remaining"
			} elseif ($Percent -ge 80) {
				$Reply = "✅ Battery $Percent% full with $Remaining min remaining"
			} else {
				$Reply = "✅ Battery at $Percent% with $Remaining min remaining"
			}
		}
		$PowerScheme = (powercfg /getactivescheme)
		$PowerScheme = $PowerScheme -Replace "^(.*)  \(",""
		$PowerScheme = $PowerScheme -Replace "\)$",""
		$Reply += ", power scheme is '$PowerScheme'"
	}
	Write-Output $Reply
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
