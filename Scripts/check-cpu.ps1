<#
.SYNOPSIS
	Checks the CPU temperature
.DESCRIPTION
	This PowerShell script queries the CPU temperature and returns it.
.EXAMPLE
	PS> ./check-cpu
	CPU is 30.3°C warm.
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
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
		$Reply = "CPU is $($Temp)°C extremely hot!"
	} elseif ($Temp -gt 50) {
		$Reply = "CPU is $($Temp)°C hot."
	} elseif ($Temp -gt 0) {
		$Reply = "CPU is $($Temp)°C warm."
	} elseif ($Temp -gt -20) {
		$Reply = "CPU is $($Temp)°C cold."
	} else {
		$Reply = "CPU is $($Temp)°C extremely cold!"
	}
	& "$PSScriptRoot/give-reply.ps1" $Reply
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
