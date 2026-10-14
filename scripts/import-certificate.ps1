function Import-Certificate
{
	<#
	.SYNOPSIS
		This function imports a certificate into any certificate store on a local computer
	.EXAMPLE
		PS> Import-Certificate -Location LocalMachine -StoreName My -FilePath C:\certificate.cer

		This example will import the certificate.cert certificate into the Personal store for the 
		local computer
	.EXAMPLE
		PS> Import-Certificate -Location CurrentUser -StoreName TrustedPublisher -FilePath C:\certificate.cer

		This example will import the certificate.cer certificate into the Trusted Publishers store for the 
		currently logged on user
	.PARAMETER Location
	 	This is the location (either CurrentUser or LocalMachine) where the store is located which the certificate
		will go into
	.PARAMETER StoreName
		This is the certificate store that the certificate will be placed into
	.PARAMETER FilePath
		This is the path to the certificate file that you'd like to import
	#>
	[CmdletBinding()]
	param
	(
		[Parameter()]
		[ValidateNotNullOrEmpty()]
		[string]$ComputerName = $env:COMPUTERNAME,
		
		[Parameter()]
		[ValidateNotNullOrEmpty()]
		[pscredential]$Credential,
		
		[Parameter(Mandatory)]
		[ValidateNotNullOrEmpty()]
		[ValidateSet('CurrentUser', 'LocalMachine')]
		[string]$Location,
		
		[Parameter(Mandatory)]
		[ValidateNotNullOrEmpty()]
		[ValidateScript({
			if ($Location -eq 'CurrentUser')
			{
				(Get-ChildItem Cert:\CurrentUser | select -ExpandProperty name) -contains $_
			}
			else
			{
				(Get-ChildItem Cert:\LocalMachine | select -ExpandProperty name) -contains $_
			}
		})]
		[string]$StoreName,
		
		[Parameter(Mandatory)]
		[string]$FilePath
	)
	begin
	{
		try
		{
			[void][System.Reflection.Assembly]::LoadWithPartialName('System.Security')
		}
		catch
		{
			$PSCmdlet.ThrowTerminatingError($_)
		}
	}
	process
	{
		try
		{
			$sb = {
				param (
					[Parameter()]
					[string]$FilePath,
					
					[Parameter()]
					[string]$Location,
					
					[Parameter()]
					[string]$StoreName
				)
				$certcoll = New-Object System.Security.Cryptography.X509Certificates.X509Certificate2Collection
				$certcoll.Import($FilePath)
				$x509Store = New-Object System.Security.Cryptography.X509Certificates.X509Store $StoreName, $Location
				$x509Store.Open([System.Security.Cryptography.X509Certificates.OpenFlags]::ReadWrite)
				$x509Store.AddRange($certcoll)
				$x509Store.Close()
			}
			$sbArgs = $FilePath, $Location, $StoreName
			if (Test-LocalComputer -ComputerName $ComputerName)
			{
				Invoke-Command -ScriptBlock $sb -Args $sbArgs
			}
			else
			{
				$connParams = @{
					'ComputerName' = $ComputerName
				}
				if ($PSBoundParameters.ContainsKey('Credential'))
				{
					$connParams.Credential = $Credential
				}
				$session = New-PSSession @connParams
				$remoteFile = Send-File -Session $session -Path $FilePath -Destination 'C:\'
				$FilePath = "C:\$([System.IO.Path]::GetFileName($FilePath))"
				$sbArgs[0] = $FilePath
				Invoke-Command -Session $session -ScriptBlock $sb -Args $sbArgs
				Invoke-Command -Session $session -ScriptBlock { Remove-Item -Path $using:FilePath -Force }
			}
		}
		catch
		{
			$PSCmdlet.ThrowTerminatingError($_)
		}
	}
}
