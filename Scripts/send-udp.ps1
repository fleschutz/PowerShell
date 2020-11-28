#!/snap/bin/powershell

# Syntax:       ./send-udp.ps1 [<IP>] [<port>] [<message>]
# Description:	sends a UDP datagram message to the given IP address and port
# Author:	Markus Fleschutz
# Source:	github.com/fleschutz/PowerShell
# License:	CC0

param([string]$TargetIP, [int]$TargetPort, [string]$Message)

if ($TargetIP -eq "" ) {
	$TargetIP = read-host "Enter target IP address"
}
if ($TargetPort -eq 0 ) {
	$TargetPort = read-host "Enter target port"
}
if ($Message -eq "" ) {
	$Message = read-host "Enter message to send"
}

try {
	$IP = [System.Net.Dns]::GetHostAddresses($TargetIP) 
	$Address = [System.Net.IPAddress]::Parse($IP) 
	$EndPoints = New-Object System.Net.IPEndPoint($Address, $TargetPort) 
	$Socket = New-Object System.Net.Sockets.UDPClient 
	$EncodedText = [Text.Encoding]::ASCII.GetBytes($Message) 
	$SendMessage = $Socket.Send($EncodedText, $EncodedText.Length, $EndPoints) 
	$Socket.Close() 
	echo "Done."
	exit 0
} catch { Write-Error $Error[0] }
exit 1
