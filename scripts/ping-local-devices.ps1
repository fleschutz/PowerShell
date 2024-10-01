<#
.SYNOPSIS
        Pings local devices
.DESCRIPTION
        This PowerShell script pings devices in the local network and lists which one are up.
.EXAMPLE
        PS> ./ping-local-hosts.ps1
	✅ Up: hippo jenkins01 jenkins02 rocket vega 
.LINK
        https://github.com/fleschutz/PowerShell
.NOTES
        Author: Markus Fleschutz | License: CC0
#>

param([int]$timeout = 600) # ms ping timeout


try {
	$names = @('accesspoint','AD','AP','amnesiac','archlinux','auriga','berlin','boston','brother','canon','castor','cisco','echodot','epson','epson2815','fedora','fireball','firewall','fritz.box','fritz.nas','fritz.powerline','fritz.repeater','gassensor','gateway','hippo','heizung','hodor','homemanager','io','iphone','jarvis','jenkins','LA','laptop','linux','jupiter','mars','mercury','miami','mobile','none','none-1','none-2','NY','o2.lte','octo','office','officepc','paris','PI','pixel-6a','PC','pluto','printer','proxy','R2D2','raspberry','rocket','rome','router','sentinel','server','shelly','shelly1','smartphone','smartwatch','soundbar','speedport.ip','sunnyboy','surface','switch','tablet','tau','tigercat','tolino','tux','TV','ubuntu','vega','venus','xrx','zeus') # sorted alphabetically
        $queue = [System.Collections.Queue]::new()
	foreach($name in $names) { $ping = [System.Net.Networkinformation.Ping]::new()
		$queue.Enqueue( @{Host=$name;Ping=$ping;Async=$ping.SendPingAsync($name,$timeout)} )
        }
	[string]$up = ""
	Write-Host "✅ Local devices: " -noNewline
	while($queue.Count -gt 0) { $obj = $queue.Dequeue()
		try { if ($obj.Async.Wait($timeout)) {
				if ($obj.Async.Result.Status -ne "TimedOut") { Write-Host "$($obj.Host) " -noNewline }
				continue
			}
		} catch { continue }
		$queue.Enqueue($obj)
	}
	Write-Host ""
	exit 0 # success
} catch {
        "⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
        exit 1
}
