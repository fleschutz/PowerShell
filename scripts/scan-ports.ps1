<#
.SYNOPSIS
	Scans the network for open/closed ports
.DESCRIPTION
	This PowerShell script scans the network for open or closed ports.
.EXAMPLE
	PS> ./scan-ports
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

$network = "192.168.178"
$port = 8080
$range = 1..254
$ErrorActionPreference= "silentlycontinue"

foreach($add in $range) {
	$ip = "{0}.{1}" -F $network,$add
	write-progress "Scanning IP $ip" -PercentComplete (($add/$range.Count)*100)
	if (Test-Connection -BufferSize 32 -Count 1 -quiet -ComputerName $ip) {
		$socket = new-object System.Net.Sockets.TcpClient($ip, $port)
		if ($socket.Connected) {
			write-output "TCP port $port at $ip is open"
			$socket.Close()
		} else {
			write-output "TCP port $port at $ip is not open"
		}
	}
}
exit 0 # success
