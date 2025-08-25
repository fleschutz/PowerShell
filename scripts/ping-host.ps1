<#
.SYNOPSIS
	Pings a host
.DESCRIPTION
	This PowerShell script pings the given host.
.PARAMETER hostname
	Specifies the hostname or IP address to ping (x.com by default)
.EXAMPLE
	PS> ./ping-host.ps1 x.com
	✅ 'x.com' is online with 20ms ping to it's IP 104.244.42.1
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

param([string]$hostname = "x.com")

try {
	$remoteHosts = $hostname.Split(",")
	$tasks = $remoteHosts | foreach { (New-Object Net.NetworkInformation.Ping).SendPingAsync($_,5000) }
	[Threading.Tasks.Task]::WaitAll($tasks)
	foreach($ping in $tasks.Result) {
		if ($ping.Status -eq "Success") {
			Write-Output "✅ '$hostname' is online with $($ping.RoundtripTime / 2)ms ping to it's IP $($ping.Address)"
			exit 0 # success
		} else {
			Write-Output "⚠️ No reply from '$hostname' (IP $($ping.Address)) - check the connection or maybe the host is down."
			exit 1
		}
	}
	Write-Output "⚠️ No reply from '$hostname' - check the connection or maybe the host is down."
	exit 1
} catch {
	"⚠️ ERROR: $($Error[0]) (script line $($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
