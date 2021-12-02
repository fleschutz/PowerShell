<#
.SYNOPSIS
	Checks the CPU 
.DESCRIPTION
	This script checks the CPU temperature.
.EXAMPLE
	PS> ./check-cpu
	✔️ CPU has 30.3 °C
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz · License: CC0
#>

try {
	if (test-path "/sys/class/thermal/thermal_zone0/temp" -pathType leaf) {
		[int]$IntTemp = get-content "/sys/class/thermal/thermal_zone0/temp"
		$Temp = [math]::round($IntTemp / 1000.0, 1)
	} else {
		$data = Get-WMIObject -Query "SELECT * FROM Win32_PerfFormattedData_Counters_ThermalZoneInformation" -Namespace "root/CIMV2"
		$Temp = @($data)[0].HighPrecisionTemperature
		$Temp = [math]::round($Temp / 100.0, 1)
	}

	if ($Temp -gt 80) {
		$Reply = "$($Temp)°C CPU temperature, that's too high!"
	} elseif ($Temp -gt 50) {
		$Reply = "$($Temp)°C CPU temperature, that's quite high"
	} elseif ($Temp -gt 0) {
		$Reply = "$(Temp)°C CPU temperature"
	} elseif ($Temp -gt -20) {
		$Reply = "$(Temp)°C CPU temperature, that's quite low"
	} else {
		$Reply = "$(Temp)°C CPU temperature, that's too low!"
	}
	"✔️ $Reply"
	& "$PSScriptRoot/speak-english.ps1" "$Reply"
	exit 0 # success
} catch {
	"⚠️ Error: $($Error[0]) ($($MyInvocation.MyCommand.Name):$($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
