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
	$Celsius = GetCPUTemperatureInCelsius
	if ($Celsius -eq 99999.9) {
		$Temp = "no temp"
	} elseif ($Celsius -gt 50) {
		$Temp = "$($Celsius)°C hot"
	} elseif ($Celsius -gt 0) {
		$Temp = "$($Celsius)°C warm"
	} else {
		$Temp = "$($Celsius)°C cold"
	} 

	if ($IsLinux) {
		"✅ CPU is $Temp."
	} else {
		$Details = Get-WmiObject -Class Win32_Processor
		$DeviceName = $Details.Name.trim()
		"✅ $($DeviceName): $($Details.DeviceID), $($Details.MaxClockSpeed)MHz, $Temp"
	}
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
