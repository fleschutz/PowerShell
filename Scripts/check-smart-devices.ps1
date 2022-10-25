<#
.SYNOPSIS
	Checks SMART devices
.DESCRIPTION
	This PowerShell script queries and prints your S.M.A.R.T. HDD/SSD devices.
.EXAMPLE
	PS> ./check-smart-devices
	✅ Device HFM256GD3JX016N via NVMe, 238GB, 126x on, 71h, 29°C, passed.
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

try {
	Write-Progress "⏳ Step 1/3 - Searching for smartctl executable..."
	$Result = (smartctl --version)
	if ($lastExitCode -ne "0") { throw "Can't execute 'smartctl' - make sure smartmontools are installed" }

	Write-Progress "⏳ Step 2/3 - Scanning S.M.A.R.T devices..."
	if ($IsLinux) {
		$Devices = $(sudo smartctl --scan-open)
	} else {
		$Devices = $(smartctl --scan-open)
	}
	foreach($Device in $Devices) {
		Write-Progress "⏳ Step 3/3 - Querying S.M.A.R.T devices..."
		$Array = $Device.split(" ")
		$Device = $Array[0]
		if ("$Device" -eq "#") {
			continue
		} elseif ($IsLinux) {
			$Details = (sudo smartctl --all --json $Device) | ConvertFrom-Json
		} else {
			$Details = (smartctl --all --json $Device) | ConvertFrom-Json
		}
		$ModelName = $Details.model_name
		$Protocol = $Details.device.protocol
		[int]$GBytes = $Details.user_capacity.bytes / 1GB
		if ($GBytes -eq 0) {
			$Capacity = ""
		} else {
			$Capacity = " $GBytes GB,"
		}
		$Temp = $Details.temperature.current
		$Firmware = $Details.firmware_version
		$PowerOn = $Details.power_cycle_count
		$Hours = $Details.power_on_time.hours
		if ($Details.smart_status.passed) { $Status = "passed" } else { $Status = "NOT PASSED" }
		"✅ Device $ModelName via $Protocol,$Capacity v$($Firmware), $($PowerOn)x on, $($Hours) hours, $($Temp)°C, $Status."
	}
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
