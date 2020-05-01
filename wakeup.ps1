function Send-WOL 
{ 
<#  
  .SYNOPSIS   
    Send a WOL packet to a broadcast address 
  .PARAMETER mac 
   The MAC address of the device that need to wake up 
  .PARAMETER ip 
   The IP address where the WOL packet will be sent to 
  .EXAMPLE  
   Send-WOL -mac 00:11:32:21:2D:11 -ip 192.168.8.255  
  .EXAMPLE  
   Send-WOL -mac 00:11:32:21:2D:11  
#> 
 
[CmdletBinding()] 
param( 
[Parameter(Mandatory=$True,Position=1)] 
[string]$mac, 
[string]$ip="255.255.255.255",  
[int]$port=9 
) 
$broadcast = [Net.IPAddress]::Parse($ip) 
  
$mac=(($mac.replace(":","")).replace("-","")).replace(".","") 
$target=0,2,4,6,8,10 | % {[convert]::ToByte($mac.substring($_,2),16)} 
$packet = (,[byte]255 * 6) + ($target * 16) 
  
$UDPclient = new-Object System.Net.Sockets.UdpClient 
$UDPclient.Connect($broadcast,$port) 
[void]$UDPclient.Send($packet, 102)  
} 

$Hostname = read-host "Enter hostname: "
$MyMACAddresses = "io=11:22:33:44:55:66","pi=11:22:33:44:55:66"

foreach($item in $MyMACAddresses) {
	$array = $item.Split("=")
	$thisHost=$array[0]
	$thisMAC=$array[1]
	if ($thisHost -like $Hostname) {
		Send-WOL $thisMAC
		echo ""
		echo "OK - host $thisHost waked up (MAC $thisMAC)."
		echo ""
		pause
		exit 0
	}
}

echo "Sorry, hostname $Hostname is unknown."
pause
exit 1