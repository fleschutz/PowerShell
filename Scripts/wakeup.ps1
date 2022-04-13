<#
.SYNOPSIS
	Sends a magic packet to a computer to wake him up
.DESCRIPTION
	This PowerShell script sends a magic UDP packet twice to a computer to wake him up (requires Wake-On-LAN).
.PARAMETER MACaddress
	Specifies the host's MAC address (e.g. 11:22:33:44:55:66)
.PARAMETER IPaddress
	Specifies the host's IP address or subnet address (e.g. 255.255.255.255)
.PARAMETER Port
	Specifies the UDP port (9 by default)
.EXAMPLE
	PS> ./wakeup 11:22:33:44:55:66 192.168.100.100
	(PC wakes up)
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz / License: CC0
#>

param([string]$MACaddress = "", [string]$IPaddress = "", [int]$Port=9)
	
function Send-WOL { param([string]$mac, [string]$ip, [int]$port) 
	$broadcast = [Net.IPAddress]::Parse($ip) 
  
	$mac=(($mac.replace(":","")).replace("-","")).replace(".","") 
	$target=0,2,4,6,8,10 | % {[convert]::ToByte($mac.substring($_,2),16)} 
	$packet = (,[byte]255 * 6) + ($target * 16) 
  
	$UDPclient = new-Object System.Net.Sockets.UdpClient 
	$UDPclient.Connect($broadcast,$port) 
	[void]$UDPclient.Send($packet, 102)  
} 

try {
	if ($MACaddress -eq "" ) { $MACaddress = read-host "Enter the host's MAC address (e.g. 00:11:22:33:44:55)"	}
	if ($IPaddress -eq "" ) { $IPaddress = read-host "Enter the host's IP address or subnet address (e.g. 255.255.255.255)" }

	Send-WOL $MACaddress $IPaddress $Port
	start-sleep -milliseconds 100
	Send-WOL $MACaddress $IPaddress $Port

	"✔️ sent magic packet $MACaddress to IP $IPaddress port $Port (twice)"
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
