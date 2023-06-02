<#
.SYNOPSIS
	Checks the ping latency 
.DESCRIPTION
	This PowerShell script checks the ping latency from the local computer to 10 popular hosts.
.PARAMETER hosts
	Specifies the hosts to check, seperated by commata (default is: amazon.com,bing.com,cnn.com,dropbox.com,facebook.com,github.com,google.com,live.com,twitter.com,youtube.com)
.EXAMPLE
	PS> ./check-ping
	✅ Ping latency is 13ms...109ms with 29ms average (0 loss)
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

param([string]$hosts = "amazon.com,bing.com,cnn.com,dropbox.com,facebook.com,github.com,google.com,live.com,twitter.com,youtube.com")

try {
	Write-Host "✅ Ping latency is" -noNewline
	$HostsArray = $hosts.Split(",")

	$t = $HostsArray | foreach {
		(New-Object Net.NetworkInformation.Ping).SendPingAsync($_, 250)
	}
	[Threading.Tasks.Task]::WaitAll($t)
	[int]$Min = 9999999
	[int]$Max = [int]$Avg = [int]$SuccessCount = [int]$LossCount = 0
	foreach($ping in $t.Result) {
		if ($ping.Status -eq "Success") {
			[int]$Latency = $ping.RoundtripTime
			if ($Latency -lt $Min) { $Min = $Latency }
			if ($Latency -gt $Max) { $Max = $Latency }
			$Avg += $Latency
			$SuccessCount++
		} else {
			$LossCount++
		}
	}
	$Avg /= $SuccessCount
	Write-Host " $($Min)ms...$($Max)ms with $($Avg)ms average ($LossCount loss)"
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
