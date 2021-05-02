<#
.SYNTAX       send-tcp.ps1 [<target-IP>] [<target-port>] [<message>]
.DESCRIPTION  sends a TCP message to the given IP address and port
.LINK         https://github.com/fleschutz/PowerShell
.NOTES        Author: Markus Fleschutz / License: CC0
#>

param($TargetIP = "", [int]$TargetPort = 0, $Message = "")
if ($TargetIP -eq "" ) { $TargetIP = read-host "Enter target IP address" }
if ($TargetPort -eq 0 ) { $TargetPort = read-host "Enter target port" }
if ($Message -eq "" ) { $Message = read-host "Enter message to send" }

try {
        $IP = [System.Net.Dns]::GetHostAddresses($TargetIP) 
        $Address = [System.Net.IPAddress]::Parse($IP) 
        $Socket = New-Object System.Net.Sockets.TCPClient($Address,$TargetPort) 
        $Stream = $Socket.GetStream() 
        $Writer = New-Object System.IO.StreamWriter($Stream)
        $Message | % {
        	$Writer.WriteLine($_)
        	$Writer.Flush()
        }
        $Stream.Close()
        $Socket.Close()

	write-host -foregroundColor green "Done."
	exit 0
} catch {
	write-error "⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
