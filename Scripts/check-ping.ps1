<#
.SYNOPSIS
	Checks the ping latency 
.DESCRIPTION
	This PowerShell script measures the ping roundtrip times from the local computer to other computers (10 Internet servers by default).
.PARAMETER hosts
	Specifies the hosts to check, seperated by commata (default is: amazon.com,bing.com,cnn.com,dropbox.com,github.com,google.com,live.com,meta.com,x.com,youtube.com)
.EXAMPLE
	PS> ./check-ping.ps1
	✅ Ping latency is 29ms average (13ms...109ms, 0/10 loss)
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

param([string]$hosts = "bing.com,cnn.com,dropbox.com,github.com,google.com,ibm.com,live.com,meta.com,x.com,youtube.com")

try {
	$hostsArray = $hosts.Split(",")
	$parallelTasks = $hostsArray | foreach {
		(New-Object Net.NetworkInformation.Ping).SendPingAsync($_, 500)
	}
	[int]$min = 9999999
	[int]$max = [int]$avg = [int]$successCount = [int]$lossCount = 0
	[int]$totalCount = $hostsArray.Count
	[Threading.Tasks.Task]::WaitAll($parallelTasks)
	foreach($ping in $parallelTasks.Result) {
		if ($ping.Status -eq "Success") {
			[int]$latency = $ping.RoundtripTime
			if ($latency -lt $min) { $min = $latency }
			if ($latency -gt $max) { $max = $latency }
			$avg += $latency
			$successCount++
		} else {
			$lossCount++
		}
	}
	if ($successCount -eq 0) {
		Write-Host "⚠️ Offline ($lossCount/$totalCount loss)"
	} else {
		$avg /= $successCount
		Write-Host "✅ Ping latency is $($avg)ms average ($($min)ms...$($max)ms, $lossCount/$totalCount loss)"
	}
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
