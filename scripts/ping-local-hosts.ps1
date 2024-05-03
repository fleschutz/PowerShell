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

$names = @('accesspoint','ad','ap','amnesiac','archlinux','auriga','berlin','boston','brother','canon','castor','cisco','echodot','epson','epson2550','epson2815','fedora','fireball','firewall','fritz.box','fritz!repeater','gassensor','gateway','hippo','heizung','hodor','homemanager','io','iphone','jarvis','jenkins','la','laptop','jupiter','mars','mercury','miami','mobile','none','none-1','none-2','ny','octopi','office','officepc','paris','pi','pixel-6a','pluto','printer','proxy','r2d2','raspberry','rocket','rome','router','sentinel','server','shelly1','smartphone','smartwatch','soundbar','sunnyboy','surface','switch','tablet','tau','tigercat','tolino','tv','ubuntu','vega','venus','xrx','zeus') # sorted alphabetically
[int]$pingTimeout = 600 # ms

try {
	Write-Progress "Sending pings to the local hosts..."

        $queue = [System.Collections.Queue]::new()
	foreach($name in $names) {
		$ping = [System.Net.Networkinformation.Ping]::new()
		$queue.Enqueue( @{Host=$name; Ping=$ping; Async=$ping.SendPingAsync($name, $pingTimeout)} )
        }

	$up = ""
	do {
		$obj = $queue.Dequeue()
		try {
                	if ($obj.Async.Wait($pingTimeout)) {
				if ($obj.Async.Result.Status -ne "TimedOut") {
					$up += "$($obj.Host) "
				}
				continue
			}
		} catch {
			if ($obj.Async.IsCompleted) { continue }
		}
		$queue.Enqueue($obj)
	} while ($queue.Count -gt 0)

	Write-Progress -completed "done."
	Write-Host "✅ Up: $($up)"
	exit 0 # success
} catch {
        "⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
        exit 1
}
