<#
.SYNOPSIS
	Checks the ping latency from the local computer to selected Internet hosts
.DESCRIPTION
	This script checks the ping latency from the local computer to selected Internet hosts.
	The hosts by default are: amazon.com,apple.com,bing.com,cnn.com,dropbox.com,facebook.com,google.com,live.com,twitter.com,youtube.com
.PARAMETER hosts
	Specifies the hosts to check (separated by comma)
.EXAMPLE
	PS> ./check-ping
	✔️ Ping is 36 ms average (13 ms min, 109 ms max, using 10 hosts)
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz · License: CC0
#>

param([string]$hosts = "amazon.com,apple.com,bing.com,cnn.com,dropbox.com,facebook.com,google.com,live.com,twitter.com,youtube.com")

try {
	write-progress "Sending pings to $hosts..."
	$HostsArray = $hosts.Split(",")
	$Pings = test-connection -count 1 -computerName $HostsArray

	[int]$Min = 9999999
	[int]$Max = 0
	[int]$Avg = 0
	foreach($Ping in $Pings) {
		if ($IsLinux) {
			[int]$Latency = $Ping.latency
		} else {
			[int]$Latency = $Ping.ResponseTime
		}
		if ($Latency -lt $Min) { $Min = $Latency }
		if ($Latency -gt $Max) { $Max = $Latency }
		$Avg += $Latency
	}
	$Avg = $Avg / $Pings.count

	"✔️ Ping is $Avg ms average ($Min ms min, $Max ms max, $($Pings.count) hosts used)"
	exit 0 # success
} catch {
	"⚠️ Error: $($Error[0]) ($($MyInvocation.MyCommand.Name):$($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
