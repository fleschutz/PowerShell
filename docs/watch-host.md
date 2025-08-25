Script: *watch-host.ps1*
========================

watch-host.ps1 


Parameters
----------
```powershell


[<CommonParameters>]
    This script supports the common parameters: Verbose, Debug, ErrorAction, ErrorVariable, WarningAction, 
    WarningVariable, OutBuffer, PipelineVariable, and OutVariable.
```

Script Content
--------------
```powershell
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
        $temp = -300 # unsupported
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
		if (($value -lt $yellowMin) -or ($value -gt $yellowMax)) {
			Write-Host "$($value)$unit" -noNewline -foregroundColor yellow
		} else {
			Write-Host "$($value)$unit" -noNewline -foregroundColor green
		}
		Write-Host "$($line.Substring(0, $total - $leftSide + 0.49))$redMax] " -noNewline
	}
}

try {
	do {
		[int]$DayOfYear = (Get-Date).DayofYear
		[int]$Time = Get-Date -format "HHmm"
		[int]$TimeZone = Get-Date -format "zz"
		$CPUtemp = GetCPUTemperature
		$numCores = $env:NUMBER_OF_PROCESSORS
		$numProcesses = (Get-Process).Count
		$load = "{0}" -f $(Get-WmiObject Win32_Processor | Measure-Object -Property LoadPercentage -Average | Select-Object -ExpandProperty Average)
		$DriveDetails = Get-PSDrive C
		$DiskUse = [math]::round($DriveDetails.Used / 1GB)
		$DiskSize = [math]::round(($DriveDetails.Used + $DriveDetails.Free) / 1GB)
		$numDaysUp = GetUptime

		if ($IsLinux) {
                	$result = $(free --mega | grep Swap:)
                	[int64]$total = $result.subString(5,14)
                	[int64]$used = $result.substring(20,13)
        	} else {
                	$items = Get-WmiObject -class "Win32_PageFileUsage" -namespace "root\CIMV2" -computername localhost
                	[int64]$total = [int64]$used = 0
                	foreach ($item in $items) {
                 		$total += $item.AllocatedBaseSize
                        	$used += $item.CurrentUsage

                	}
		}

		Clear-Host
		Write-Host "Host $env:COMPUTERNAME"
		Write-Host "=================="
		Write-Host "`n* DATE " -noNewline
		WriteValueInRange $DayOfYear "" 0 0 366 366
		Write-Host "`n* TIME " -noNewline
		WriteValueInRange $Time "" 0 0 2400 2400
		Write-Host "`n* ZONE " -noNewline
		WriteValueInRange $TimeZone "" -23 -23 23 23
		if ($CPUtemp -ne -300) {
			Write-Host "`n* CPU  " -noNewline
			WriteValueInRange $CPUtemp "°C" 0 10 80 100
		}
		Write-Host "`n* CPU  " -noNewline
		WriteValueInRange $numCores " cores" 0 0 100 100
		Write-Host "`n* LOAD " -noNewline
		WriteValueInRange $load "%" 0 0 90 100
		Write-Host "`n* PROC " -noNewline
		WriteValueInRange $numProcesses "" 0 10 900 1000
		Write-Host "`n* SWAP " -noNewline
		WriteValueInRange $used "GB" 0 0 ($total - 1) $total
		Write-Host "`n* DISK " -noNewline
		WriteValueInRange $DiskUse "GB" 0 0 ($DiskSize - 5) $DiskSize
		Write-Host "`n* UP   " -noNewline
		WriteValueInRange $numDaysUp " days" 0 0 1000 1000


		Start-Sleep -milliseconds 5000
	} while ($true)
} catch {
	"⚠️ ERROR: $($Error[0]) (script line $($_.InvocationInfo.ScriptLineNumber))"
        exit 1
}
```

*(page generated by convert-ps2md.ps1 as of 08/25/2025 16:51:29)*
