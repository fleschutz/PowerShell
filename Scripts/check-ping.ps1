<#
.SYNOPSIS
	Checks the ping latency 
.DESCRIPTION
	This PowerShell script checks the ping latency from the local computer to 9 popular hosts.
.PARAMETER hosts
	Specifies the hosts to check, seperated by commata (default is: amazon.com,bing.com,cnn.com,dropbox.com,facebook.com,google.com,live.com,twitter.com,youtube.com)
.EXAMPLE
	PS> ./check-ping
	✅ Ping latency is 13ms...109ms with 25ms average.
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

param([string]$hosts = "amazon.com,bing.com,cnn.com,dropbox.com,facebook.com,google.com,live.com,twitter.com,youtube.com")

try {
	Write-Progress "⏳ Sending pings to 9 popular hosts..."
	$HostsArray = $hosts.Split(",")
	if ($IsLinux) {
		$t = $HostsArray | foreach {
			(New-Object Net.NetworkInformation.Ping).SendPingAsync($_, 250)
		}
		[Threading.Tasks.Task]::WaitAll($t)
		[int]$Min = 9999999
		[int]$Max = [int]$Avg = [int]$Count = 0
		foreach($ping in $t.Result) {
			if ($ping.Status -eq "Success") {
				[int]$Latency = $ping.RoundtripTime
				if ($Latency -lt $Min) { $Min = $Latency }
				if ($Latency -gt $Max) { $Max = $Latency }
				$Avg += $Latency
				$Count++
			}
		}
		$Avg /= $Count
	} else {
		$Pings = Test-Connection -computerName $HostsArray -count 1

		[int]$Min = 9999999
		[int]$Max = [int]$Avg = 0
		foreach($Ping in $Pings) {
			if ($IsLinux) {	[int]$Latency = $Ping.latency } else { [int]$Latency = $Ping.ResponseTime }
			if ($Latency -lt $Min) { $Min = $Latency }
			if ($Latency -gt $Max) { $Max = $Latency }
			$Avg += $Latency
		}
		$Avg /= $Pings.count
	}

	Write-Progress -Completed "."
	Write-Host "✅ Ping latency is $($Min)ms...$($Max)ms with $($Avg)ms average"
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
