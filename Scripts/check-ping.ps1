#!/bin/powershell
<#
.SYNTAX       ./check-ping.ps1 
.DESCRIPTION  checks the ping latency to the internet
.LINK         https://github.com/fleschutz/PowerShell
.NOTES        Author: Markus Fleschutz / License: CC0
#>

try {
	write-verbose "Sending pings to the internet ..."
	$Pings = test-connection -count 1 -computerName heise.de,cnn.com,github.com,www.microsoft.com,dropbox.com,amazon.com,google.com,bing.com,youtube.com

	[int]$Min = 9999999
	[int]$Max = 0
	[int]$Avg = 0
	foreach($Ping in $Pings) {
		if ($Ping.latency -lt $Min) { $Min = $Ping.latency }
		if ($Ping.latency -gt $Max) { $Max = $Ping.latency }
		$Avg += $Ping.latency
	}
	$Avg = $Avg / $Pings.count

	write-host -foregroundColor green "OK - $Avg ms average ping latency ($Min ms min, $Max ms max)"
	exit 0
} catch {
	write-error "ERROR: line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
