<#
.SYNOPSIS
	Lists the phone calls of the FRITZ!Box device
.DESCRIPTION
	This PowerShell script lists the phone calls of the FRITZ!Box device.
.PARAMETER Username
	Specifies the user name for FRITZ!Box
.PARAMETER Password
	Specifies the password to FRITZ!Box
.EXAMPLE
	PS> ./list-fritzbox-calls.ps1
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
$FQDN = "fritz.box"

[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.SecurityProtocolType]'Tls,Tls11,Tls12'

[xml]$serviceinfo = Invoke-RestMethod -Method GET -Uri "http://$($FQDN):49000/tr64desc.xml"
[System.Xml.XmlNamespaceManager]$ns = new-Object System.Xml.XmlNamespaceManager $serviceinfo.NameTable
$ns.AddNamespace("ns",$serviceinfo.DocumentElement.NamespaceURI)
[System.Net.ServicePointManager]::ServerCertificateValidationCallback = { $true }


function Execute-SOAPRequest { param([Xml]$SOAPRequest, [string]$soapactionheader, [String]$URL)
    try {
        $wr = [System.Net.WebRequest]::Create($URL)
        $wr.Headers.Add('SOAPAction',$soapactionheader)
        $wr.ContentType = 'text/xml; charset="utf-8"'
        $wr.Accept      = 'text/xml'
        $wr.Method      = 'POST'
        $wr.PreAuthenticate = $true
        $wr.Credentials = [System.Net.NetworkCredential]::new($Username,$Password)

        $requestStream = $wr.GetRequestStream()
        $SOAPRequest.Save($requestStream)
        $requestStream.Close()
        [System.Net.HttpWebResponse]$wresp = $wr.GetResponse()
        $responseStream = $wresp.GetResponseStream()
        $responseXML = [Xml]([System.IO.StreamReader]($responseStream)).ReadToEnd()
        $responseStream.Close()
        return $responseXML
    } catch {
        if ($_.Exception.InnerException.Response){
            throw ([System.IO.StreamReader]($_.Exception.InnerException.Response.GetResponseStream())).ReadToEnd()
        } else {
            throw $_.Exception.InnerException
        }
    }
}

function New-Request {
    param(
        [parameter(Mandatory=$true)][ValidateNotNullOrEmpty()][string]$urn,
        [parameter(Mandatory=$true)][ValidateNotNullOrEmpty()][string]$action,
        [hashtable]$parameter = @{},
        $Protocol = 'https'
    )
        # SOAP Request Body Template
        [xml]$request = @"
<?xml version="1.0"?>
<s:Envelope xmlns:s="http://schemas.xmlsoap.org/soap/envelope/" s:encodingStyle="http://schemas.xmlsoap.org/soap/encoding/">
    <s:Body>
    </s:Body>
</s:Envelope>
"@
    $service = $serviceinfo.SelectNodes('//ns:service',$ns) | ?{$_.ServiceType -eq $URN}
    if(!$service){throw "URN does not exist."}
    $actiontag = $request.CreateElement('u',$action,$service.serviceType)
    $parameter.GetEnumerator() | %{
          $el = $request.CreateElement($_.Key)
          $el.InnerText = $_.Value
          $actiontag.AppendChild($el)| out-null
    }
    $request.GetElementsByTagName('s:Body')[0].AppendChild($actiontag) | out-null
    $resp = Execute-SOAPRequest $request "$($service.serviceType)#$($action)" "$($Protocol)://$($FQDN):$(@{$true=$script:secport;$false=49000}[($Protocol -eq 'https')])$($service.controlURL)"
    return $resp
}

$script:secport = (New-Request -urn "urn:dslforum-org:service:DeviceInfo:1" -action 'GetSecurityPort' -proto 'http').Envelope.Body.GetSecurityPortResponse.NewSecurityPort

function GetCallList { param([int]$MaxEntries = 999, [int]$MaxDays = 999
    )
    $resp = New-Request -urn 'urn:dslforum-org:service:X_AVM-DE_OnTel:1' -action 'GetCallList'
    $list = [xml](new-object System.Net.WebClient).DownloadString("$($resp.Envelope.Body.GetCallListResponse.NewCallListURL)&max=$MaxEntries&MaxDays=$days")
    return $list.root.call
}

GetCallList | format-table -property Date,Duration,Caller,Called
echo $Result
exit 0 # success
