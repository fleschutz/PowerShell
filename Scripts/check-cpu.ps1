<#
.SYNOPSIS
	Checks the CPU status
.DESCRIPTION
	This PowerShell script queries the CPU status and prints it (name, type, speed, temperature, etc).
.EXAMPLE
	PS> ./check-cpu
	✅ AMD Ryzen 5 5500U with Radeon Graphics (CPU0, 2100MHz, 31.3°C)
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

function GetProcessorArchitecture {
	if ("$env:PROCESSOR_ARCHITECTURE" -ne "") { return "$env:PROCESSOR_ARCHITECTURE" }
	if ($IsLinux) {
		$Name = $PSVersionTable.OS
		if ($Name -like "*-generic *") {
			if ([System.Environment]::Is64BitOperatingSystem) { return "x64" } else { return "x86" }
		} elseif ($Name -like "*-raspi *") {
			if ([System.Environment]::Is64BitOperatingSystem) { return "ARM64" } else { return "ARM32" }
		} else {
			return ""
		}
	}
}

try {
	Write-Progress "⏳ Querying CPU details..."
	$Status = "✅"
	$Celsius = GetCPUTemperatureInCelsius
	if ($Celsius -eq 99999.9) {
		$Temp = "no temp"
	} elseif ($Celsius -gt 50) {
		$Temp = "$($Celsius)°C"
		$Status = "⚠"
	} elseif ($Celsius -lt 0) {
		$Temp = "$($Celsius)°C"
		$Status = "⚠"
	} else {
		$Temp = "$($Celsius)°C"
	} 

	$Arch = GetProcessorArchitecture
	if ($IsLinux) {
		$CPUName = "$Arch CPU"
		$Arch = ""
		$DeviceID = ""
		$Speed = ""
		$Socket = ""
	} else {
		$Details = Get-WmiObject -Class Win32_Processor
		$CPUName = $Details.Name.trim()
		$Arch = "$Arch, "
		$DeviceID = "$($Details.DeviceID), "
		$Speed = "$($Details.MaxClockSpeed)MHz, "
		$Socket = "$($Details.SocketDesignation) socket, "
	}
	$Cores = [System.Environment]::ProcessorCount
	Write-Progress -completed "done."
	Write-Host "$Status $CPUName ($($Arch)$Cores cores, $($DeviceID)$($Speed)$($Socket)$Temp)"
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
