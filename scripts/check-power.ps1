<#
.SYNOPSIS
	Checks the power status
.DESCRIPTION
	This PowerShell script queries the power status and prints it.
.EXAMPLE
	PS> ./check-power.ps1
	⚠️ Battery at 9% with power scheme 'HP Optimized' - 54min remaining
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

try {
	if ($IsLinux) {
		$reply = "✅ AC powered" # TODO, just guessing :-)
	} else {
		Add-Type -Assembly System.Windows.Forms
		$details = [System.Windows.Forms.SystemInformation]::PowerStatus
		[int]$percent = 100 * $details.BatteryLifePercent
		[int]$remaining = $details.BatteryLifeRemaining / 60
		$powerScheme = (powercfg /getactivescheme)
		$powerScheme = $powerScheme -Replace "^(.*)  \(",""
		$powerScheme = $powerScheme -Replace "\)$",""
		if ($details.PowerLineStatus -eq "Online") {
			if ($details.BatteryChargeStatus -eq "NoSystemBattery") {
				$reply = "✅ AC powered"
			} elseif ($percent -ge 95) {
				$reply = "✅ Battery nearly full ($percent%, power scheme '$powerScheme')"
			} else {
				$reply = "✅ Battery charging ($percent%, power scheme '$powerScheme')"
			}
		} else { # must be offline
			if (($remaining -eq 0) -and ($percent -ge 60)) {
				$reply = "✅ Battery $percent% full (power scheme '$powerScheme')"
			} elseif ($remaining -eq 0) {
				$reply = "✅ Battery at $percent% (power scheme '$powerScheme')"
			} elseif ($remaining -le 5) {
				$reply = "⚠️ Battery at $percent% (power scheme '$powerScheme') - ONLY $($remaining)min remaining"
			} elseif ($remaining -le 30) {
				$reply = "⚠️ Battery at $percent% (power scheme '$powerScheme') - only $($remaining)min remaining"
			} elseif ($percent -lt 10) {
				$reply = "⚠️ Battery at $percent% (power scheme '$powerScheme') - $($remaining)min remaining"
			} elseif ($percent -ge 80) {
				$reply = "✅ Battery $percent% full (power scheme '$powerScheme') - $($remaining)min remaining"
			} else {
				$reply = "✅ Battery at $percent% (power scheme '$powerScheme') - $($remaining)min remaining"
			}
		}
	}
	Write-Host $reply
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
