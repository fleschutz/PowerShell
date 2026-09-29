
<#PSScriptInfo

.VERSION 1.0

.COPYRIGHT 

.TAGS 

.LICENSEURI 

.PROJECTURI 

.ICONURI 

.EXTERNALMODULEDEPENDENCIES 

.REQUIREDSCRIPTS 

.EXTERNALSCRIPTDEPENDENCIES 

.RELEASENOTES


#>

<# 

.DESCRIPTION 
 A script to test if a TCP or UDP port is open. 

#> 
[CmdletBinding(DefaultParameterSetName = 'TCP')]
[OutputType([System.Management.Automation.PSCustomObject])]
param (
	[Parameter(Mandatory)]
	[string]$ComputerName,
	
	[Parameter(Mandatory)]
	[int]$Port,
	
	[Parameter()]
	[ValidateSet('TCP', 'UDP')]
	[string]$Protocol = 'TCP',
	
	[Parameter(ParameterSetName = 'TCP')]
	[int]$TcpTimeout = 1000,
	
	[Parameter(ParameterSetName = 'UDP')]
	[int]$UdpTimeout = 1000
)
process
{
	if ($Protocol -eq 'TCP')
	{
		$TcpClient = New-Object System.Net.Sockets.TcpClient
		$Connect = $TcpClient.BeginConnect($ComputerName, $Port, $null, $null)
		$Wait = $Connect.AsyncWaitHandle.WaitOne($TcpTimeout, $false)
		if (!$Wait)
		{
			$TcpClient.Close()
		}
		else
		{
			$TcpClient.EndConnect($Connect)
			$TcpClient.Close()
			$result = $true
		}
		$TcpClient.Close()
		$TcpClient.Dispose()
	}
	elseif ($Protocol -eq 'UDP')
	{
		$UdpClient = New-Object System.Net.Sockets.UdpClient
		$UdpClient.Client.ReceiveTimeout = $UdpTimeout
		$UdpClient.Connect($ComputerName, $Port)
		$a = new-object system.text.asciiencoding
		$byte = $a.GetBytes("$(Get-Date)")
		[void]$UdpClient.Send($byte, $byte.length)
		#IPEndPoint object will allow us to read datagrams sent from any source.
		Write-Verbose "$($MyInvocation.MyCommand.Name) - Creating remote endpoint"
		$remoteendpoint = New-Object system.net.ipendpoint([system.net.ipaddress]::Any, 0)
		try
		{
			#Blocks until a message returns on this socket from a remote host.
			Write-Verbose "$($MyInvocation.MyCommand.Name) - Waiting for message return"
			$receivebytes = $UdpClient.Receive([ref]$remoteendpoint)
			[string]$returndata = $a.GetString($receivebytes)
			If ($returndata)
			{
				$result = $true
			}
		}
		catch
		{
			Write-Error "$($MyInvocation.MyCommand.Name) - '$ComputerName' failed port test on port '$Protocol`:$Port' with error '$($_.Exception.Message)'"
		}
		$UdpClient.Close()
		$UdpClient.Dispose()
	}
	if ($result)
	{
		$true
	}
	else
	{
		$false
	}
}
