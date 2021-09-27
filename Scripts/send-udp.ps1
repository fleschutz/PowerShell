<#
.SYNOPSIS
	send-udp.ps1 [<target-IP>] [<target-port>] [<message>]
.DESCRIPTION
	Sends a UDP datagram message to the given IP address and port
.EXAMPLE
	PS> ./send-udp 192.168.100.100 8080 "TEST"
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

param([string]$TargetIP = "", [int]$TargetPort = 0, $[string]Message = "")

try {
	if ($TargetIP -eq "" ) { $TargetIP = read-host "Enter target IP address" }
	if ($TargetPort -eq 0 ) { $TargetPort = read-host "Enter target port" }
	if ($Message -eq "" ) { $Message = read-host "Enter message to send" }

	$IP = [System.Net.Dns]::GetHostAddresses($TargetIP) 
	$Address = [System.Net.IPAddress]::Parse($IP) 
	$EndPoints = New-Object System.Net.IPEndPoint($Address, $TargetPort) 
	$Socket = New-Object System.Net.Sockets.UDPClient 
	$EncodedText = [Text.Encoding]::ASCII.GetBytes($Message) 
	$SendMessage = $Socket.Send($EncodedText, $EncodedText.Length, $EndPoints) 
	$Socket.Close() 

	"✔️  Done."
	exit 0 # success
} catch {
	"⚠️ Error: $($Error[0]) ($($MyInvocation.MyCommand.Name):$($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
