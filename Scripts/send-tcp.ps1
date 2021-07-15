<#
.SYNOPSIS
	send-tcp.ps1 [<target-IP>] [<target-port>] [<message>]
.DESCRIPTION
	Sends a TCP message to the given IP address and port
.EXAMPLE
	PS> .\send-tcp.ps1 192.168.100.100 8080 "TEST"
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz / License: CC0
#>

param([string]$TargetIP = "", [int]$TargetPort = 0, [string]$Message = "")

try {
	if ($TargetIP -eq "" ) { $TargetIP = read-host "Enter target IP address" }
	if ($TargetPort -eq 0 ) { $TargetPort = read-host "Enter target port" }
	if ($Message -eq "" ) { $Message = read-host "Enter message to send" }

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
