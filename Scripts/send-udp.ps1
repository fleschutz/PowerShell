#!/snap/bin/powershell

# Syntax:       ./send-udp.ps1 [<IP>] [<port>] [<message>]
# Description:	sends a UDP datagram message to the given IP address and port
# Author:	Markus Fleschutz
# Source:	github.com/fleschutz/PowerShell
# License:	CC0

param([string]$IP, [int]$Port, [string]$Message)

if ($IP -eq "" ) {
	$IP = read-host "Enter target IP address"
}
if ($Port -eq 0 ) {
	$Port = read-host "Enter target port"
}
if ($Message -eq "" ) {
	$Message = read-host "Enter message to send"
}

function Send-UdpDatagram
{
      param([string]$EndPoint, [int]$Port, [string]$Message)

      $IP = [System.Net.Dns]::GetHostAddresses($EndPoint) 
      $Address = [System.Net.IPAddress]::Parse($IP) 
      $EndPoints = New-Object System.Net.IPEndPoint($Address, $Port) 
      $Socket = New-Object System.Net.Sockets.UDPClient 
      $EncodedText = [Text.Encoding]::ASCII.GetBytes($Message) 
      $SendMessage = $Socket.Send($EncodedText, $EncodedText.Length, $EndPoints) 
      $Socket.Close() 
}

Send-UdpDatagram $IP $Port $Message
echo "Done."
exit 0
