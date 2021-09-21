<#
.SYNOPSIS
	check-ping.ps1 [<hosts>]
.DESCRIPTION
	Checks the ping latency from the local computer to Internet hosts.
	(default is: 'amazon.com,bing.com,cnn.com dropbox.com,ebay.com,facebook.com,google.com,youtube.com)
.EXAMPLE
	PS> .\check-ping.ps1
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz · License: CC0
#>

param([string]$hosts = "amazon.com,bing.com,cnn.com,dropbox.com,ebay.com,facebook.com,google.com,youtube.com")

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

	"✔️ $Avg ms average ping latency ($Min ms min, $Max ms max)"
	exit 0
} catch {
	"⚠️ Error: $($Error[0]) ($($MyInvocation.MyCommand.Name):$($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
