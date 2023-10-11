<#
.SYNOPSIS
	Checks the uptime 
.DESCRIPTION
	This PowerShell script queries the computer's uptime (time between now and last boot up time) and prints it.
.EXAMPLE
	PS> ./check-uptime.ps1
	✅ Up for 2 days, 20 hours, 10 minutes
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

try {
	if ($IsLinux) {
		$uptime = (Get-Uptime)
	} else {
		$lastBootTime = (Get-CimInstance Win32_OperatingSystem).LastBootUpTime 
		$uptime = New-TimeSpan -Start $lastBootTime -End (Get-Date)
	}
	$reply = "✅ Up for "
	$days = $uptime.Days
	if ($days -eq "1") {
		$reply += "1 day, "
	} elseif ($days -ne "0") {
		$reply += "$days days, "
	}

	$hours = $uptime.Hours
	if ($hours -eq "1") {
		$reply += "1 hour, "
	} elseif ($hours -ne "0") {
		$reply += "$hours hours, "
	}

	$minutes = $uptime.Minutes 
	if ($minutes -eq "1") {
		$reply += "1 minute"
	} else {
		$reply += "$minutes minutes"
	}
	Write-Host $reply
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
