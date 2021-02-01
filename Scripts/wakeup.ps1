#!/snap/bin/powershell
<#
.SYNTAX         ./wakeup.ps1 [<hostname>] [<MAC-address>]
.DESCRIPTION	sends a magic packet to the given computer, waking him up
.LINK		https://github.com/fleschutz/PowerShell
.NOTES		Author:	Markus Fleschutz / License: CC0
#>

param([string]$Hostname = "", [string]MACaddress = "")

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
	if ($Hostname -eq "" ) {
		$Hostname = read-host "Enter hostname or IP address"
	}
	if ($MACaddress -eq "" ) {
		$MACaddress = read-host "Enter the MAC address"
	}
	Send-WOL $MACaddress $Hostname
	write-output "OK - sent magic packet to $Hostname (MAC $MACaddress) to wake him up"
	exit 0
} catch {
	write-error "ERROR in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
