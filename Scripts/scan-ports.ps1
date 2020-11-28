#!/snap/bin/powershell

# Syntax:       ./scan-ports.ps1
# Description:	scans the network for open/closed ports
# Author:	Markus Fleschutz
# Source:	github.com/fleschutz/PowerShell
# License:	CC0

$network = "192.168.178"
$port = 8080
$range = 1..254
$ErrorActionPreference= "silentlycontinue"

foreach($add in $range) {
	$ip = "{0}.{1}" -F $network,$add
	Write-Progress "Scanning IP $ip" -PercentComplete (($add/$range.Count)*100)
	if (Test-Connection -BufferSize 32 -Count 1 -quiet -ComputerName $ip) {
		$socket = new-object System.Net.Sockets.TcpClient($ip, $port)
		if ($socket.Connected) {
			write-host "TCP port $port at $ip is open"
			$socket.Close()
		} else {
			write-host "TCP port $port at $ip is not open"
		}
	}
}
exit 0
