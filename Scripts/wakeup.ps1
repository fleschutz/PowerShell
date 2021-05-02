<#
.SYNTAX       wakeup.ps1 [<MAC-address>] [<IP-address>]
.DESCRIPTION  sends a magic packet to the given computer to wake him up
.LINK         https://github.com/fleschutz/PowerShell
.NOTES        Author: Markus Fleschutz / License: CC0
#>

param($MACaddress = "", $IPaddress = "", [int]$Port=9)
if ($MACaddress -eq "" ) { $MACaddress = read-host "Enter the MAC address (e.g. 00:11:22:33:44:55)"	}
if ($IPaddress -eq "" ) { $IPaddress = read-host "Enter the IP address or subnet address (e.g. 255.255.255.255)" }
	
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
	Send-WOL $MACaddress $IPaddress $Port
	start-sleep -milliseconds 100
	Send-WOL $MACaddress $IPaddress $Port

	write-host -foregroundColor green "✔️ magic packet $MACaddress sent twice to IP $IPaddress port $Port"
	exit 0
} catch {
	write-error "⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
