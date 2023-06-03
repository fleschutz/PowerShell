<#
.SYNOPSIS
	Checks the ping latency 
.DESCRIPTION
	This PowerShell script measures the ping roundtrip times from the local computer to 10 Internet servers.
.PARAMETER hosts
	Specifies the hosts to check, seperated by commata (default is: amazon.com,bing.com,cnn.com,dropbox.com,facebook.com,github.com,google.com,live.com,twitter.com,youtube.com)
.EXAMPLE
	PS> ./check-ping
	✅ Ping latency is 29ms average (13ms...109ms, 0 loss)
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

param([string]$hosts = "amazon.com,bing.com,cnn.com,dropbox.com,facebook.com,github.com,google.com,live.com,twitter.com,youtube.com")

try {
	Write-Host "✅ Ping latency is" -noNewline
	$hostsArray = $hosts.Split(",")
	$t = $hostsArray | foreach {
		(New-Object Net.NetworkInformation.Ping).SendPingAsync($_, 250)
	}
	[Threading.Tasks.Task]::WaitAll($t)
	[int]$min = 9999999
	[int]$max = [int]$avg = [int]$successCount = [int]$lossCount = 0
	foreach($ping in $t.Result) {
		if ($ping.Status -eq "Success") {
			[int]$latency = $ping.RoundtripTime
			if ($latency -lt $min) { $min = $Latency }
			if ($latency -gt $max) { $max = $Latency }
			$avg += $latency
			$successCount++
		} else {
			$lossCount++
		}
	}
	$avg /= $successCount
	Write-Host " $($avg)ms average ($($min)ms...$($max)ms, $lossCount loss)"
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
