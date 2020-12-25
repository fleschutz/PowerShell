#!/snap/bin/powershell

# Syntax:       ./send-tcp.ps1 [<IP>] [<port>] [<message>]
# Description:	sends a TCP message to the given IP address and port
# Author:	Markus Fleschutz
# Source:	github.com/fleschutz/PowerShell
# License:	CC0

param([string]$TargetIP, [int]$TargetPort, [string]$Message)

try {
	if ($TargetIP -eq "" ) {
		$TargetIP = read-host "Enter target IP address"
	}
	if ($TargetPort -eq 0 ) {
		$TargetPort = read-host "Enter target port"
	}
	if ($Message -eq "" ) {
		$Message = read-host "Enter message to send"
	}

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

	write-output "Done."
	exit 0
} catch {
	write-error "ERROR in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
