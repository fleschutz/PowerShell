<#
.SYNOPSIS
	Check uptime 
.DESCRIPTION
	This PowerShell script queries and prints the uptime.
.EXAMPLE
	PS> ./check-uptime
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

try {
	if ($IsLinux) {
		$Uptime = (get-uptime)
	} else {
		$BootTime = Get-WinEvent -ProviderName eventlog | Where-Object {$_.Id -eq 6005} | Select-Object TimeCreated -First 1 
		$Uptime = New-TimeSpan -Start $BootTime.TimeCreated.Date -End (Get-Date)
	}
	$Days = $Uptime.Days
	$Hours = $Uptime.Hours
	$Minutes = $Uptime.Minutes 

	$Reply = "Up for "
	if ($Days -eq "1") {
		$Reply += "1 day, "
	} elseif ($Days -ne "0") {
		$Reply += "$Days days, "
	}
	if ($Hours -eq "1") {
		$Reply += "1 hour, "
	} elseif ($Hours -ne "0") {
		$Reply += "$Hours hours, "
	}
	if ($Minutes -eq "1") {
		$Reply += "1 minute"
	} else {
		$Reply += "$Minutes minutes"
	}
	"✅ $Reply."
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
