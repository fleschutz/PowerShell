<#
.SYNOPSIS
	Checks the uptime 
.DESCRIPTION
	This PowerShell script queries the computer's uptime (time between now and last boot up time) and prints it.
.EXAMPLE
	PS> ./check-uptime.ps1
	✅ OfficePC is up for 13 days since 1/25/2024
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
	$hostname = $(hostname)
	if ($IsLinux) {
		$uptime = (Get-Uptime)
		Write-Host "✅ $hostname is up for $(TimeSpan2String $uptime)"
	} else {
		[system.threading.thread]::currentthread.currentculture = [system.globalization.cultureinfo]"en-US"
		$lastBootTime = (Get-CimInstance Win32_OperatingSystem).LastBootUpTime 
		$uptime = New-TimeSpan -Start $lastBootTime -End (Get-Date)
		Write-Host "✅ $hostname is up for $(TimeSpan2String $uptime) since $($lastBootTime.ToShortDateString())"
	}
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
