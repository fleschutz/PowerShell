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

function GetCPUTemperatureInCelsius {
	$Temp = 99999.9 # unsupported
	if ($IsLinux) {
		if (Test-Path "/sys/class/thermal/thermal_zone0/temp" -pathType leaf) {
			[int]$IntTemp = Get-Content "/sys/class/thermal/thermal_zone0/temp"
			$Temp = [math]::round($IntTemp / 1000.0, 1)
		}
	} else {
		$Objects = Get-WmiObject -Query "SELECT * FROM Win32_PerfFormattedData_Counters_ThermalZoneInformation" -Namespace "root/CIMV2"
		foreach ($Obj in $Objects) {
			$HiPrec = $Obj.HighPrecisionTemperature
			$Temp = [math]::round($HiPrec / 100.0, 1)
		}
	}
	return $Temp;
}

try {
	$Temp = GetCPUTemperatureInCelsius
	if ($Temp -eq 99999.9) {
		"⚠️ CPU temperature query is unsupported."
	} elseif ($Temp -gt 80) {
		"⚠️ CPU is too hot at $($Temp)°C!"
	} elseif ($Temp -gt 50) {
		"✅ CPU is $($Temp)°C hot."
	} elseif ($Temp -gt 0) {
		"✅ CPU is $($Temp)°C warm."
	} elseif ($Temp -gt -20) {
		"✅ CPU is $($Temp)°C cold."
	} else {
		"⚠️ CPU is too cold at $($Temp)°C!"
	}
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
