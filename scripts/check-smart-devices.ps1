<#
.SYNOPSIS
	Checks the SMART device status
.DESCRIPTION
	This PowerShell script queries the status of the SSD/HDD devices (supporting S.M.A.R.T.) and prints it.
.EXAMPLE
	PS> ./check-smart-devices.ps1
	✅ 1TB Samsung SSD 970 EVO via NVMe (37°C, 2388 hours, 289x on/off, v2B2QEXE7) - selftest OK
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

function Bytes2String([int64]$bytes) {
	if ($bytes -lt 1000) { return "$bytes bytes" }
	$bytes /= 1000
	if ($bytes -lt 1000) { return "$($bytes)KB" }
	$bytes /= 1000
	if ($bytes -lt 1000) { return "$($bytes)MB" }
	$bytes /= 1000
	if ($bytes -lt 1000) { return "$($bytes)GB" }
	$bytes /= 1000
	if ($bytes -lt 1000) { return "$($bytes)TB" }
	$bytes /= 1000
	if ($bytes -lt 1000) { return "$($bytes)PB" }
	$bytes /= 1000
	if ($bytes -lt 1000) { return "$($bytes)EB" }
}

try {
	#Write-Progress "(1/3) Searching for smartmontools..."
	$result = (smartctl --version)
	if ($lastExitCode -ne "0") { throw "Can't execute 'smartctl' - make sure smartmontools are installed" }

	#Write-Progress "(2/3) Scanning S.M.A.R.T devices..."
	if ($IsLinux) {
		$devices = $(sudo smartctl --scan-open)
	} else {
		$devices = $(smartctl --scan-open)
	}

	#Write-Progress "Querying S.M.A.R.T devices..."
	foreach($device in $devices) {
		$array = $device.split(" ")
		$dev = $array[0]
		if ("$dev" -eq "#") {
			continue
		} elseif ($IsLinux) {
			$details = (sudo smartctl --all --json $dev) | ConvertFrom-Json
			$null = (sudo smartctl --test=conveyance $dev)
		} else {
			$details = (smartctl --all --json $dev) | ConvertFrom-Json
			$null = (smartctl --test=conveyance $dev)
		}
		$status = "✅"
		$modelName = $details.model_name
		$protocol = $details.device.protocol
		[int64]$bytes = $details.user_capacity.bytes
		if ($bytes -gt 0) {
			$capacity = "$(Bytes2String $bytes) "
		} else {
			$capacity = ""
		}
		if ($details.temperature.current -gt 50) {
			$temp = "$($details.temperature.current)°C (!)"
			$status = "⚠️"
		} else {
			$temp = "$($details.temperature.current)°C"
		}
		if ($details.power_on_time.hours -gt 87600) { # 10 years
			$hours = "$($details.power_on_time.hours) hours (!)"
			$status = "⚠️"
		} else {
			$hours = "$($details.power_on_time.hours) hours"
		}
		if ($details.power_cycle_count -gt 100000) { 
			$powerOn = "$($details.power_cycle_count)x on/off (!)"
			$status = "⚠️"
		} else {
			$powerOn = "$($details.power_cycle_count)x on/off"
		}	
		if ($details.smart_status.passed) {
			$selftest = "selftest OK"
		} else {
			$selftest = "selftest FAILED"
			$status = "⚠️"
		}
		$firmwareVersion = $details.firmware_version
		Write-Host "$status $capacity$modelName via $protocol ($temp, $hours, $powerOn, v$firmwareVersion) - $selftest"
	}
	#Write-Progress -completed "Done."
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
