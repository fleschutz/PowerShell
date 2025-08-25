<#
.SYNOPSIS
	Watch pinging a host
.DESCRIPTION
	This PowerShell script pings the given host continously and shows the roundtrip times in a horizontal chart.
.PARAMETER hostname
	Specifies the hostname or IP address to ping (windows.com by default)
.PARAMETER timeInterval
	Specifies the time interval in milliseconds between two pings (1000 by default)
.EXAMPLE
	PS> ./watch-ping.ps1

	   PING ROUNDTRIP TIMES TO: windows.com
	#1 ██████████████ 136ms
	#2 ████████████████ 154ms
	#3 █████████████████████████ 234ms
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
	$num = ($value * 108.0) / $maxValue
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
	Write-Host "`n   PING ROUNDTRIP TIMES TO: $hostname" -foregroundColor green
	[int]$count = 1
	do {
		Write-Host "#$count " -noNewline
		[float]$latency = GetPingLatency $hostname
		WriteChartLine $latency 1000.0 "$($latency)ms"
		Start-Sleep -Milliseconds $timeInterval
		$count++
	} while($true)
	exit 0 # success
} catch {
	"⚠️ ERROR: $($Error[0]) (script line $($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
