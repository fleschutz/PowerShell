<#
.SYNOPSIS
	Checks the ping latency 
.DESCRIPTION
	This PowerShell script checks the ping latency from the local computer to the given hosts.
.PARAMETER hosts
	Specifies the hosts to check, seperated by commata (default is: amazon.com,bing.com,cnn.com,dropbox.com,facebook.com,google.com,live.com,twitter.com,youtube.com)
.EXAMPLE
	PS> ./check-ping
	✅ Ping latency is 13ms...109ms, 25ms average.
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

param([string]$hosts = "amazon.com,bing.com,cnn.com,dropbox.com,facebook.com,google.com,live.com,twitter.com,youtube.com")

try {
	Write-Progress "⏳ Pinging hosts in parallel..."
	$HostsArray = $hosts.Split(",")
	$Pings = Test-Connection -computerName $HostsArray -count 1

	Write-Progress "⏳ Calculating results..."
	[int]$Min = 9999999
	[int]$Max = [int]$Avg = 0
	foreach($Ping in $Pings) {
		if ($IsLinux) {	[int]$Latency = $Ping.latency } else { [int]$Latency = $Ping.ResponseTime }
		if ($Latency -lt $Min) { $Min = $Latency }
		if ($Latency -gt $Max) { $Max = $Latency }
		$Avg += $Latency
	}
	$Avg /= $Pings.count

	Write-Host "✅ Ping latency is $($Min)ms...$($Max)ms, $($Avg)ms average"
	Write-Progress -Completed "Ping finished." 
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}