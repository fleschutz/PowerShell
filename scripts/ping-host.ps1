<#
.SYNOPSIS
	Ping a host continuously
.DESCRIPTION
	This PowerShell script pings the given host continously and shows the roundtrip times in a horizontal chart.
.PARAMETER hostname
	Specifies the hostname or IP address of the host to ping (windows.com by default)
.PARAMETER timeInterval
	Specifies the time interval in milliseconds to repeat the ping (1000 by default)
.EXAMPLE
	PS> ./ping-host.ps1
	
	Ping Roundtrip Times to Host: windows.com
	██████████████ 136ms
	████████████████ 154ms
	█████████████████████████ 234ms
	...
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

param([string]$hostname = "windows.com", [int]$timeInterval = 1000)

function GetPingLatency([string]$hostname) {
	$hostsArray = $hostname.Split(",")
	$tasks = $hostsArray | foreach {
		(New-Object Net.NetworkInformation.Ping).SendPingAsync($_,1000)
	}
	[Threading.Tasks.Task]::WaitAll($tasks)
	foreach($ping in $tasks.Result) { 
        	if ($ping.Status -eq "Success") { return $ping.RoundtripTime }
	}
	return 1000
}

function WriteChartLine { param([float]$value, [float]$maxValue, [string]$text)
	$num = ($value * 110.0) / $maxValue
	while ($num -ge 1.0) {
		Write-Host -noNewLine "█"
		$num -= 1.0
	}
	if ($num -ge 0.875) {
		Write-Host -noNewLine "▉"
	} elseif ($num -ge 0.75) {
		Write-Host -noNewLine "▊"
	} elseif ($num -ge 0.625) {
		Write-Host -noNewLine "▋"
	} elseif ($num -ge 0.5) {
		Write-Host -noNewLine "▌"
	} elseif ($num -ge 0.375) {
		Write-Host -noNewLine "▍"
	} elseif ($num -ge 0.25) {
		Write-Host -noNewLine "▎"
	} elseif ($num -ge 0.125) {
		Write-Host -noNewLine "▏"
	}
	Write-Host " $text"
}

try {
	Write-Host "`nPing Roundtrip Times to Host: $($hostname)" -foregroundColor green
	do {
		[float]$latency = GetPingLatency $hostname
		WriteChartLine $latency 1000.0 "$($latency)ms"
		Start-Sleep -Milliseconds $timeInterval
	} while($true)
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}