<#
.SYNTAX       check-ping.ps1 
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
	write-error "⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
