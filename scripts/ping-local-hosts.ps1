<#
.SYNOPSIS
        Pings local hosts
.DESCRIPTION
        This PowerShell script pings the computers in the local network and lists which one are up.
.EXAMPLE
        PS> ./ping-local-hosts.ps1
	✅ Up: hippo jenkins01 jenkins02 rocket vega 
.LINK
        https://github.com/fleschutz/PowerShell
.NOTES
        Author: Markus Fleschutz | License: CC0
#>

$hostsArray = @('amnesiac','archlinux','berlin','boston','brother','canon','castor','cisco','echodot','epson','fedora','fireball','firewall','fritz.box','gassensor','gateway','hippo','heizung','homemanager','io','iphone','jarvis','jenkins','la','laptop','jupiter','mars','mercury','miami','mobile','ny','octopi','office','officepc','paris','pi','pixel-6a','pluto','printer','proxy','r2d2','raspberry','rocket','rome','router','server','shelly1','smartphone','smartwatch','soundbar','sunnyboy','surface','switch','tablet','tau','tolino','tv','ubuntu','vega','venus','xrx','zeus') # sorted alphabetically
[int]$pingTimeout = 600 # ms

try {
	Write-Progress "Sending pings to the local hosts..."
        $queue = [System.Collections.Queue]::new()
	foreach($hostname in $hostsArray) {
		$ping = [System.Net.Networkinformation.Ping]::new()
		$obj = @{ Host = $hostname; Ping = $ping; Async = $ping.SendPingAsync($hostname, $pingTimeout) }
 		$queue.Enqueue($obj)
        }

	[string]$result = ""
	while ($queue.Count -gt 0) {
		$obj = $queue.Dequeue()
		try {
                	if ($obj.Async.Wait($pingTimeout) -eq $true) {
				if ($obj.Async.Result.Status -ne "TimedOut") {
					$result += "$($obj.Host) "
				}
				continue
			}
		} catch {
			if ($obj.Async.IsCompleted -eq $true) {	continue }
		}
		$queue.Enqueue($obj)
	}
	Write-Progress -completed "Done."
	Write-Host "✅ Up: $($result)"
	exit 0 # success
} catch {
        "⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
        exit 1
}
