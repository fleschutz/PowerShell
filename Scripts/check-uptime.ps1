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

function TimeSpan2String([TimeSpan]$uptime)
{
	[int]$days = $uptime.Days
	[int]$hours = $days * 24 + $uptime.Hours
	if ($days -gt 2) {
		return "$days days"
	} elseif ($hours -gt 1) {
		return "$hours hours"
	} else {
		return "$($uptime.Minutes)min"
	}
}

try {
	if ($IsLinux) {
		$uptime = (Get-Uptime)
		Write-Host "✅ Up for $(TimeSpan2String $uptime)"
	} else {
		[system.threading.thread]::currentthread.currentculture = [system.globalization.cultureinfo]"en-US"
		$lastBootTime = (Get-CimInstance Win32_OperatingSystem).LastBootUpTime 
		$uptime = New-TimeSpan -Start $lastBootTime -End (Get-Date)
		Write-Host "✅ Up for $(TimeSpan2String $uptime) since $($lastBootTime.ToShortDateString())"
	}
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
