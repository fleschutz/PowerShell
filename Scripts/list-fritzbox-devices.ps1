#!/snap/bin/powershell
<#
.SYNTAX         ./list-fritzbox-calls.ps1 [<username>] [<password>]
.DESCRIPTION	lists the phone calls of the FRITZ!Box device
.LINK		https://github.com/fleschutz/PowerShell
.NOTES		Author:	Markus Fleschutz / License: CC0
#>

param (
	[String]$hostURL = "https://fritz.box:49443",  # IP of fritz-box 
	[string]$SOAPAction="urn:dslforum-org:service:Hosts:1#X_AVM-DE_GetHostListPath",
  [Parameter(Mandatory=$true)][string]$Username = "",   # username for Fritz!Box
  [Parameter(Mandatory=$true)][string]$FBKennwort="",   # password for Fritz!Box
  [switch]$onlyactive,    #limit to active hosts 
  [switch]$prtg,          #return PRTX XML wit num of active and passice hosts
  [switch]$prtgdetail     #return full xml with a channel per mac, be careful with many hosts
)

write-host "get-fritzmactable: Start"

if ($FBKennwort -eq "") {
  Write-Host "Password required"
  Write-Error "Password required"
  exit
}


Write-host "  Prepare SOAP-Request"
[string]$SOAPrequest = @"
<?xml version="1.0"?>
<s:Envelope xmlns:s="http://schemas.xmlsoap.org/soap/envelope/" s:encodingStyle="http://schemas.xmlsoap.org/soap/encoding/">
  <s:Body>
    <u:X_AVM-DE_GetHostListPath xmlns:u="urn:dslforum-org:service:Hosts:1" />
  </s:Body>
</s:Envelope>
"@

Write-host " Prepare Credentials"
$secure_pwd = $FBKennwort | ConvertTo-SecureString -AsPlainText -Force
$creds = New-Object System.Management.Automation.PSCredential -ArgumentList $Username, $secure_pwd

Write-Host " Request DownloadURL via SOAP"
$ReturnXml = Invoke-RestMethod `
   -Method POST `
   -Headers @{'SOAPAction'=($soapaction)} `
   -Uri ($hostURL+"/upnp/control/hosts") `
   -Credential $creds `
   -ContentType 'text/xml' `
   -Body $SOAPrequest

Write-host " Download MAC-List from ($hostURL($($ReturnXml.Envelope.Body.'X_AVM-DE_GetHostListPathResponse'.'NewX_AVM-DE_HostListPath')))"
$devicehostlist = invoke-restmethod `
                    -Uri ($hostURL+($ReturnXml.Envelope.Body.'X_AVM-DE_GetHostListPathResponse'.'NewX_AVM-DE_HostListPath'))
# convert System.Xml.XmlLinkedNode to standard Object
$mactable = $devicehostlist.List.Item.GetEnumerator() |  ConvertTo-Csv | ConvertFrom-Csv
Write-host "Total Entries: $($mactable.count)"

Write-host " Loading List Done"
if ($prtgdetail) {
  "<?xml version=""1.0"" encoding=""UTF-8"" ?>
  <prtg>
    <result>
      <channel>Active Hosts</channel>
      <value>$(($mactable | where-object {$_.active -eq 1}).count)</value>
      <float>0</float>
    </result>
    <result>
      <channel>Passive Hosts</channel>
      <value>$(($mactable | where-object {$_.active -eq 0}).count)</value>
      <float>0</float>
    </result>
    <result>
      <channel>Guest Hosts</channel>
      <value>$(($mactable | where-object {$_."X_AVM-DE_Guest" -eq 1}).count)</value>
      <float>0</float>
    </result>"
  foreach ($mac in $mactable) {
    "<result>
      <channel>$($mac.MACAddress)</channel>
      <value>$($mac.active)</value>
      <float>0</float>
    </result>"
  }

    "<text>Anzahl der Eintraege in der FB MacTabelle</text>
  </prtg>"
}
elseif ($prtg) {
  "<?xml version=""1.0"" encoding=""UTF-8"" ?>
  <prtg>
    <result>
      <channel>Active Hosts</channel>
      <value>$(($mactable | where-object {$_.active -eq 1}).count)</value>
      <float>0</float>
    </result>
    <result>
      <channel>Passive Hosts</channel>
      <value>$(($mactable | where-object {$_.active -eq 0}).count)</value>
      <float>0</float>
    </result>
    <result>
      <channel>Guest Hosts</channel>
      <value>$(($mactable | where-object {$_."X_AVM-DE_Guest" -eq 1}).count)</value>
      <float>0</float>
    </result>
    <text>Anzahl der Eintraege in der FB MacTabelle</text>
  </prtg>"

}
else {
  if ($onlyactive) {
    Write-Host "Export active entries"
    $mactable | where-object {$_.active -eq 1}
  }
  else {
    Write-Host "Export all entries"
    $mactable
  }
}
