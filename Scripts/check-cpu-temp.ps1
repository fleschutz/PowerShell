#!/usr/bin/pwsh
<#
.SYNTAX       ./check-cpu-temp.ps1 
.DESCRIPTION  checks the CPU temperature
.LINK         https://github.com/fleschutz/PowerShell
.NOTES        Author: Markus Fleschutz / License: CC0
#>

try {
	if (test-path "/sys/class/thermal/thermal_zone0/temp") {
		[int]$IntTemp = get-content "/sys/class/thermal/thermal_zone0/temp"
		$Temp = [math]::round($IntTemp / 1000.0, 1)
	} else {
		write-warning "Sorry, no CPU temperature available"
		exit 0
	}

	if ($Temp -gt "80") {
		write-error "FAIL - $Temp °C CPU temperature is too high!"
		exit 1
	} elseif ($Temp -lt "-20") {
		write-error "FAIL - $Temp °C CPU temperature is too low!"
		exit 1
	} elseif ($Temp -gt "50") {
		write-warning "$Temp °C CPU temperature is quite high"
	} elseif ($Temp -lt "0") {
		write-warning "$Temp °C CPU temperature is quite low"
	} else {
		write-host -foregroundColor green "OK - $Temp °C CPU temperature"
	}
	exit 0
} catch {
	write-error "ERROR: line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
