<#
.SYNOPSIS
	Pings a host
.DESCRIPTION
	This PowerShell script pings the given host.
.PARAMETER hostname
	Specifies the hostname or IP address to ping (x.com by default)
.EXAMPLE
	PS> ./ping-host.ps1 x.com
	✅ Host 'x.com' is up with 23ms ping latency.
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

param([string]$hostname = "x.com")

function GetPingLatency([string]$hostname) {
	$hostsArray = $hostname.Split(",")
	$tasks = $hostsArray | foreach { (New-Object Net.NetworkInformation.Ping).SendPingAsync($_,3000) }
	[Threading.Tasks.Task]::WaitAll($tasks)
	foreach($ping in $tasks.Result) { if ($ping.Status -eq "Success") { return $ping.RoundtripTime } }
	return -1
}

try {
	[int]$latency = GetPingLatency($hostname)
	if ($latency -lt 0) {
		Write-Host "⚠️ Host '$hostname' doesn't respond - check the connection or maybe the host is down."
		exit 1
	} 
	Write-Host "✅ Host '$hostname' is up with $($latency)ms ping latency."
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}