<#
.SYNOPSIS
	Pings a host
.DESCRIPTION
	This PowerShell script pings the given host.
.PARAMETER hostname
	Specifies the hostname or IP address to ping (x.com by default)
.EXAMPLE
	PS> ./ping-host.ps1 x.com
	✅ Host 'x.com' is UP (20ms latency to IP 104.244.42.65).
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

param([string]$hostname = "x.com")

try {
	$remoteHosts = $hostname.Split(",")
	$tasks = $remoteHosts | foreach { (New-Object Net.NetworkInformation.Ping).SendPingAsync($_,3000) }
	[Threading.Tasks.Task]::WaitAll($tasks)
	foreach($ping in $tasks.Result) {
		if ($ping.Status -eq "Success") {
			Write-Host "✅ Host '$hostname' is UP ($($ping.RoundtripTime)ms latency to IP $($ping.Address))."
			exit 0 # success
		}
	}
	Write-Host "⚠️ Host '$hostname' doesn't respond - check the connection or maybe the host is down (yet)."
	exit 1
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}