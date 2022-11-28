<#
.SYNOPSIS
	Checks the ping latency 
.DESCRIPTION
	This PowerShell script checks the ping latency from the local computer to some Internet hosts.
.PARAMETER hosts
	Specifies the hosts to check, seperated by comma (default is: amazon.com,bing.com,cnn.com,dropbox.com,facebook.com,google.com,live.com,twitter.com,youtube.com)
.EXAMPLE
	PS> ./check-ping
	✅ Ping is 25ms average, 13ms min, 109ms max.
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

param([string]$hosts = "amazon.com,bing.com,cnn.com,dropbox.com,facebook.com,google.com,live.com,twitter.com,youtube.com")

try {
	Write-Progress "⏳ Pinging $hosts..."
	$HostsArray = $hosts.Split(",")
	$Pings = Test-Connection -count 1 -computerName $HostsArray

	[int]$Min = 9999999
	[int]$Max = [int]$Avg = 0
	foreach($Ping in $Pings) {
		if ($IsLinux) {	[int]$Latency = $Ping.latency } else { [int]$Latency = $Ping.ResponseTime }
		if ($Latency -lt $Min) { $Min = $Latency }
		if ($Latency -gt $Max) { $Max = $Latency }
		$Avg += $Latency
	}
	$Avg /= $Pings.count
	"✅ Ping is $($Avg)ms average, $($Min)ms min, $($Max)ms max"
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}