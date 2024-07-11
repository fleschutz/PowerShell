<#
.SYNOPSIS
	Pings remote hosts to measure the latency 
.DESCRIPTION
	This PowerShell script measures the ping roundtrip times from the local computer to remote ones (10 Internet servers by default).
.PARAMETER hosts
	Specifies the hosts to ping, seperated by commata (10 Internet servers by default)
.EXAMPLE
	PS> ./ping-remote-hosts.ps1
	✅ Online with 0/10 ping loss and 11...40ms latency - 18ms average
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

param([string]$hosts = "bing.com,cnn.com,dropbox.com,github.com,google.com,ibm.com,live.com,meta.com,x.com,youtube.com")

try {
	$hostsArray = $hosts.Split(",")
	$tasks = $hostsArray | foreach { (New-Object Net.NetworkInformation.Ping).SendPingAsync($_,1000)	}
	[int]$min = 9999999
	[int]$max = [int]$avg = [int]$success = 0
	[int]$total = $hostsArray.Count
	[Threading.Tasks.Task]::WaitAll($tasks)
	foreach($ping in $tasks.Result) {
		if ($ping.Status -ne "Success") { continue }
		$success++
		[int]$latency = $ping.RoundtripTime
		$avg += $latency
		if ($latency -lt $min) { $min = $latency }
		if ($latency -gt $max) { $max = $latency }
	}
	[int]$loss = $total - $success
	if ($success -ne 0) {
		$avg /= $success
		Write-Host "✅ Online with $loss/$total ping loss and $($min)...$($max)ms latency - $($avg)ms average"
	} else {
		Write-Host "⚠️ Offline ($loss/$total ping loss)"
	}
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
