<#
.SYNOPSIS
	Writes a value with unit and range
.DESCRIPTION
	This PowerShell script writes the given value with the unit and the value range to the console.
.PARAMETER value
	Specifies the value
.EXAMPLE
	PS> ./write-value.ps1 95.0 "°C" 0 10 90 100
	[0--------95°C-100]
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

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

function GetUptime {
	if ($IsLinux) {
                $uptime = (Get-Uptime)
        } else {
                $lastBootTime = (Get-CimInstance Win32_OperatingSystem).LastBootUpTime
                $uptime = New-TimeSpan -Start $lastBootTime -End (Get-Date)
        }
	return $uptime.Days
}

function WriteValueInRange([float]$value, [string]$unit, [float]$redMin, [float]$yellowMin, [float]$yellowMax, [float]$redMax) {
	$line = "------------------------------------------------"
	$text = "[$redMin$($value)$unit $redMax]"
	[float]$total = 20.0 - $text.Length
	if ($value -gt $redMax) {
		Write-Host "[$redMin$($line.Substring(0, $total))$redMax]" -noNewline
		Write-Host "$($value)$unit " -noNewline -foregroundColor red
	} elseif ($value -lt $redMin) {
		Write-Host "$($value)$unit" -noNewline -foregroundColor red
		Write-Host "[$redMin$($line.Substring(0, $total))$redMax] " -noNewline
	} else {
		[float]$leftSide = (($value - $redMin) * $total) / ($redMax - $redMin)
		if ($leftSide -lt 1.0) { $leftSide = 1.0 }
		if ($leftSide -gt ($total - 1.0)) { $leftSide = $total - 1.0 }
		Write-Host "[$redMin$($line.Substring(0, $leftSide))" -noNewline
		if (($value -le $yellowMin) -or ($value -ge $yellowMax)) {
			Write-Host "$($value)$unit" -noNewline -foregroundColor yellow
		} else {
			Write-Host "$($value)$unit" -noNewline -foregroundColor green
		}
		Write-Host "$($line.Substring(0, $total - $leftSide + 0.49))$redMax] " -noNewline
	}
}

try {
	do {
		$CPUtemp = GetCPUTemperature
		$numProcesses = (Get-Process).Count
		$numDaysUp = GetUptime

		Clear-Host
		Write-Host "`n* CPU TEMP  " -noNewline
		WriteValueInRange $CPUtemp "°C" 0 10 80 100
		Write-Host "`n* PROCESSES " -noNewline
		WriteValueInRange $numProcesses "" 0 10 900 1000
		Write-Host "`n* UPTIME    " -noNewline
		WriteValueInRange $numDaysUp " days" 0 0 900 1000


		Start-Sleep -milliseconds 1000
	} while ($true)
} catch {
        "⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
        exit 1
}