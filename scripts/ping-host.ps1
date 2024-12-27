<#
.SYNOPSIS
	Pings a host
.DESCRIPTION
	This PowerShell script pings the given host.
.PARAMETER hostname
	Specifies the hostname or IP address to ping (x.com by default)
.EXAMPLE
	PS> ./ping-host.ps1 x.com
	✅ Host 'x.com' at IP 104.244.42.1 is up with 20ms latency.
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
			Write-Output "✅ Host '$hostname' at IP $($ping.Address) is up with $($ping.RoundtripTime)ms latency."
			exit 0 # success
		}
	}
	Write-Output "⚠️ Host '$hostname' doesn't respond - check the connection or maybe the host is down."
	exit 1
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}