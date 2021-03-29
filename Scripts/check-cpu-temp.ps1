#!/bin/powershell
<#
.SYNTAX       ./check-cpu-temp.ps1 
.DESCRIPTION  checks the CPU temperature
.LINK         https://github.com/fleschutz/PowerShell
.NOTES        Author: Markus Fleschutz / License: CC0
#>

try {
	if (test-path "/sys/class/thermal/thermal_zone0/temp") {
		$Temp = get-content "/sys/class/thermal/thermal_zone0/temp"
		$Temp = $Temp / 1000.0
	} else {
		write-warning "Sorry, no CPU temperature available"
		exit 0
	}

	if ($Temp -gt "80") {
		write-error "CPU has $Temp °C - too high!"
		exit 1
	} elseif ($Temp -lt "-20") {
		write-error "CPU has $Temp °C - too low!"
		exit 1
	} elseif ($Temp -gt "50") {
		write-warning "CPU has $Temp °C - quite high"
	} elseif ($Temp -lt "0") {
		write-warning "CPU has $Temp °C - quite low"
	} else {
		write-host -foregroundColor green "OK - CPU has $Temp °C"
	}
	exit 0
} catch {
	write-error "ERROR: line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
