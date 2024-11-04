<#
.SYNOPSIS
	Pings a host
.DESCRIPTION
	This PowerShell script pings the given host.
.PARAMETER hostname
	Specifies the hostname or IP address to ping (windows.com by default)
.EXAMPLE
	PS> ./ping-host.ps1 x.com
	✅ x.com is up with 10ms latency.
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

param([string]$hostname = "windows.com")

function GetPingLatency([string]$hostname) {
	$hostsArray = $hostname.Split(",")
	$tasks = $hostsArray | foreach {
		(New-Object Net.NetworkInformation.Ping).SendPingAsync($_,1500)
	}
	[Threading.Tasks.Task]::WaitAll($tasks)
	foreach($ping in $tasks.Result) { 
        	if ($ping.Status -eq "Success") { return $ping.RoundtripTime }
	}
	return 1500
}

try {
	[int]$latency = GetPingLatency($hostname)
	if ($latency -eq 1500) {
		Write-Host "⚠️ Host '$hostname' is offline"
	} else {
		Write-Host "✅ $hostname is up with $($latency)ms ping latency."
	}
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}