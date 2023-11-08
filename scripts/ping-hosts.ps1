<#
.SYNOPSIS
        Pings the local hosts
.DESCRIPTION
        This PowerShell script pings well-known hostnames in the local network and lists which one up.
.EXAMPLE
        PS> ./check-hosts.ps1
	✅ Up are: Hippo Jenkins01 Jenkins02 Rocket Vega
.LINK
        https://github.com/fleschutz/PowerShell
.NOTES
        Author: Markus Fleschutz | License: CC0
#>

try {
	[string]$hosts = "Amnesiac,ArchLinux,Berlin,Boston,Brother,Canon,Castor,Cisco,Epson,Fedora,Fireball,Firewall,fritz.box,Gateway,Hippo,Io,Jarvis,Jenkins01,Jenkins02,LA,Laptop,Jupiter,Mars,Mercury,Miami,Mobile,NY,OctoPi,Paris,Pluto,Printer,Proxy,R2D2,Raspberry,Rocket,Rome,Router,Server,SmartPhone,SmartWatch,Sunnyboy,Tablet,Ubuntu,Vega,Venus,XRX,Zeus" # sorted alphabetically
	[int]$timeout = 600 # milliseconds
	$hostsArray = $hosts.Split(",")
	$count = $hostsArray.Count

	Write-Progress "Sending pings to $count local hosts..."
        $queue = [System.Collections.Queue]::new()
	foreach($hostname in $hostsArray) {
		$ping = [System.Net.Networkinformation.Ping]::new()
		$object = @{ Host = $hostname; Ping = $ping; Async = $ping.SendPingAsync($hostname, $timeout) }
 		$queue.Enqueue($object)
        }

	[string]$result = ""
	while ($queue.Count -gt 0) {
		$object = $queue.Dequeue()
		try {
                	if ($object.Async.Wait($timeout) -eq $true) {
				if ($object.Async.Result.Status -ne "TimedOut") {
					$result += "$($object.Host) "
				}
				continue
			}
		} catch {
			if ($object.Async.IsCompleted -eq $true) {
				continue
			}
		}
		$queue.Enqueue($object)
	}
	Write-Progress -completed "Done."
	Write-Host "✅ Up are: $result"
	exit 0 # success
} catch {
        "⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
        exit 1
}