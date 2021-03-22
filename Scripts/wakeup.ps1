#!/bin/powershell
<#
.SYNTAX       ./wakeup.ps1 [<MAC-address>] [<IP-address>]
.DESCRIPTION  sends a magic packet to the given computer to wake him up
.LINK         https://github.com/fleschutz/PowerShell
.NOTES        Author: Markus Fleschutz / License: CC0
#>

param($MACaddress = "", $IPaddress = "")

function Send-WOL { param([string]$mac, [string]$ip="255.255.255.255", [int]$port=9) 
	$broadcast = [Net.IPAddress]::Parse($ip) 
  
	$mac=(($mac.replace(":","")).replace("-","")).replace(".","") 
	$target=0,2,4,6,8,10 | % {[convert]::ToByte($mac.substring($_,2),16)} 
	$packet = (,[byte]255 * 6) + ($target * 16) 
  
	$UDPclient = new-Object System.Net.Sockets.UdpClient 
	$UDPclient.Connect($broadcast,$port) 
	[void]$UDPclient.Send($packet, 102)  
} 

try {
	if ($MACaddress -eq "" ) {
		$MACaddress = read-host "Enter the MAC address (e.g. 00:11:22:33:44:55)"
	}
	if ($IPaddress -eq "" ) {
		$IPaddress = read-host "Enter the IP address or subnet address (e.g. 255.255.255.255)"
	}

	Send-WOL $MACaddress $IPaddress
	start-sleep -milliseconds 100
	Send-WOL $MACaddress $IPaddress

	write-host -foregroundColor green "Done - magic packet sent twice to IP $IPaddress (MAC $MACaddress)"
	exit 0
} catch {
	write-error "ERROR: line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
