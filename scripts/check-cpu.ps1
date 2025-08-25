<#
.SYNOPSIS
	Checks the CPU status
.DESCRIPTION
	This PowerShell script queries the CPU status (name, type, speed, temperature, etc) and prints it.
.EXAMPLE
	PS> ./check-cpu.ps1
	✅ Intel(R) Core(TM) i9-10900X CPU @ 3.70GHz (AMD64, 20 cores, CPU0, 3696MHz, CPU0 socket, 31.3°C)
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

function GetCPUArchitecture {
	if ("$env:PROCESSOR_ARCHITECTURE" -ne "") { return "$env:PROCESSOR_ARCHITECTURE" }
	if ($IsLinux) {
		$Name = $PSVersionTable.OS
		if ($Name -like "*-generic *") {
			if ([System.Environment]::Is64BitOperatingSystem) { return "x64" } else { return "x86" }
		} elseif ($Name -like "*-raspi *") {
			if ([System.Environment]::Is64BitOperatingSystem) { return "ARM64" } else { return "ARM32" }
		} elseif ([System.Environment]::Is64BitOperatingSystem) { return "64-bit" } else { return "32-bit" }
	}
}

function GetCPUTemperature {
	$temp = 99999.9 # unsupported
	if ($IsLinux) {
		if (Test-Path "/sys/class/thermal/thermal_zone0/temp" -pathType leaf) {
			[int]$IntTemp = Get-Content "/sys/class/thermal/thermal_zone0/temp"
			$temp = [math]::round($IntTemp / 1000.0, 1)
		}
	} else {
		$objects = Get-WmiObject -Query "SELECT * FROM Win32_PerfFormattedData_Counters_ThermalZoneInformation" -Namespace "root/CIMV2"
		foreach ($object in $objects) {
			$highPrec = $object.HighPrecisionTemperature
			$temp = [math]::round($highPrec / 100.0, 1)
		}
	}
	return $temp
}

try {
	Write-Progress "Querying CPU status..."
	$status = "✅"
	$arch = GetCPUArchitecture
	if ($IsLinux) {
		$cpuName = "$arch CPU"
		$arch = ""
		$deviceID = ""
		$speed = ""
		$socket = ""
	} else {
		$details = Get-WmiObject -Class Win32_Processor
		$cpuName = $details.Name.trim()
		$arch = "$arch, "
		$deviceID = ", $($details.DeviceID)"
		$speed = ", $($details.MaxClockSpeed)MHz"
		$socket = ", $($details.SocketDesignation) socket"
	}
	$cores = [System.Environment]::ProcessorCount
	$celsius = GetCPUTemperature
	if ($celsius -eq 99999.9) {
		$temp = ""
	} elseif ($celsius -gt 80) {
		$temp = ", $($celsius)°C TOO HOT"
		$status = "⚠️"
	} elseif ($celsius -gt 50) {
		$temp = ", $($celsius)°C HOT"
		$status = "⚠️"
	} elseif ($celsius -lt 0) {
		$temp = ", $($celsius)°C TOO COLD"
		$status = "⚠️"
	} else {
		$temp = ", $($celsius)°C"
	} 

	Write-Progress -completed "Done."
	Write-Host "$status $cpuName ($($arch)$cores cores$($temp)$($deviceID)$($speed)$($socket))"
	exit 0 # success
} catch {
	"⚠️ ERROR: $($Error[0]) (script line $($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
