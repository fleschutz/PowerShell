<#
.SYNOPSIS
	Lists FRITZ!Box's known devices
.DESCRIPTION
	This PowerShell script lists FRITZ!Box's known devices.
.PARAMETER Username
	Specifies the user name to FRITZ!Box
.PARAMETER Password
	Specifies the password to FRITZ!Box
.EXAMPLE
	PS> ./list-fritzbox-devices.ps1
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

#Requires -Version 3

param([string]$Username = "", [string]$Password = "")

if ($Username -eq "") { $Username = read-host "Enter username for FRITZ!Box" }
if ($Password -eq "") { $Password = read-host "Enter password for FRITZ!Box" }

write-progress "Contacting FRITZ!Box ..."
[string]$HostURL = "https://fritz.box:49443"
[string]$SOAPAction="urn:dslforum-org:service:Hosts:1#X_AVM-DE_GetHostListPath"
[string]$SOAPrequest = @"
<?xml version="1.0"?>
<s:Envelope xmlns:s="http://schemas.xmlsoap.org/soap/envelope/" s:encodingStyle="http://schemas.xmlsoap.org/soap/encoding/">
  <s:Body>
    <u:X_AVM-DE_GetHostListPath xmlns:u="urn:dslforum-org:service:Hosts:1" />
  </s:Body>
</s:Envelope>
"@

$SecurePassword = $Password | ConvertTo-SecureString -AsPlainText -Force
$Credentials = New-Object System.Management.Automation.PSCredential -ArgumentList $Username, $SecurePassword

$XmlResult = invoke-restMethod `
   -Method POST `
   -Headers @{'SOAPAction'=($SOAPAction)} `
   -Uri ($HostURL+"/upnp/control/hosts") `
   -Credential $Credentials `
   -ContentType 'text/xml' `
   -Body $SOAPrequest

$HostList = invoke-restMethod -Uri ($HostURL+($XmlResult.Envelope.Body.'X_AVM-DE_GetHostListPathResponse'.'NewX_AVM-DE_HostListPath'))

$HostTable = $HostList.List.Item.GetEnumerator() 

$HostTable | format-table -property Active,IPAddress,MACAddress,HostName,InterfaceType,X_AVM-DE_Speed

exit 0 # success
