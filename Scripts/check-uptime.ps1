<#
.SYNOPSIS
	Checks the uptime 
.DESCRIPTION
	This PowerShell script queries the computer's uptime and prints it.
.EXAMPLE
	PS> ./check-uptime
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

try {
	if ($IsLinux) {
		$Uptime = (Get-Uptime)
	} else {
		$BootTime = Get-WinEvent -ProviderName eventlog | Where-Object {$_.Id -eq 6005} | Select-Object TimeCreated -First 1 
		$Uptime = New-TimeSpan -Start $BootTime.TimeCreated.Date -End (Get-Date)
	}
	$Reply = "✅ Up for "
	$Days = $Uptime.Days
	if ($Days -eq "1") {
		$Reply += "1 day, "
	} elseif ($Days -ne "0") {
		$Reply += "$Days days, "
	}

	$Hours = $Uptime.Hours
	if ($Hours -eq "1") {
		$Reply += "1 hour, "
	} elseif ($Hours -ne "0") {
		$Reply += "$Hours hours, "
	}

	$Minutes = $Uptime.Minutes 
	if ($Minutes -eq "1") {
		$Reply += "1 minute"
	} else {
		$Reply += "$Minutes minutes"
	}
	Write-Host $Reply
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}